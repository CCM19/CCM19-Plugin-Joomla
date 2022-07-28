<?php /** @noinspection ALL */
/**
 * @package    ccm19integration
 *
 * @author     Papoo Software & Media GmbH info@ccm19.de
 * @copyright  Papoo Software & Media GmbH
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 * @link       https://www.ccm19.de/
 */

defined('_JEXEC') or die;

use Joomla\CMS\Application\CMSApplication;
use Joomla\CMS\HTML\HTMLHelper;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\CMS\Uri\Uri;
use Joomla\Component\Actionlogs\Administrator\Helper\ActionlogsHelper;

/**
 * Ccm19integration plugin.
 *
 * @package   ccm19integration
 * @since     1.0.0
 */
class plgSystemCcm19integration extends CMSPlugin
{
	/**
	 * Application object
	 *
	 * @var    CMSApplication
	 * @since  1.0.0
	 */
	protected $app;

	/**
	 * Database object
	 *
	 * @var    JDatabaseDriver
	 * @since  1.0.0
	 */
	protected $db;

	/**
	 * Affects constructor behavior. If true, language files will be loaded automatically.
	 *
	 * @var    boolean
	 * @since  1.0.0
	 */
	protected $autoloadLanguage = true;

	protected $status = true;



	/**
	 * onAfterDispatch.
	 *
	 * @throws Exception
	 * @since   1.0
	 */
	public function onAfterDispatch()
	{



		}


    public function onExtensionAfterSave($context, $table, $isNew): void
    {

        $sample = $this -> params -> get('sample');
        $sample = $this -> getIntegrationUrl($sample);
        if (!empty(JPluginHelper ::getPlugin('system', 'ccm19integration') -> id)) {
            $id = JPluginHelper ::getPlugin('system', 'ccm19integration') -> id;
        }

        $uri = Uri ::getInstance();
        $current = (int)$uri -> getVar('extension_id');

        if ($sample === null && ($current === $id)) {
            JFactory::getApplication()->enqueueMessage(JText::_('PLG_SYSTEM_CCM19INTEGRATION_INVALID_SNIPPET'), 'error');
        }
    }
	/**
	 * onBeforeCompileHead
	 *
	 * @return void
	 *
	 * @since 1.0
	 */
	public function onBeforeCompileHead()
	{

		$refinedsample =array('url' => $this->getIntegrationUrl($this->params->get('sample')));

		$app = $this->app;

		if (($app !== null) && $app -> isClient('site'))
		{
			$assetManager = $app->getDocument()->getWebAssetManager();

			$assetManager->registerScript(
				'plg.system.ccm19integration',
				'plg_system_ccm19integration/insert.js',
				['version' => 'auto', 'relative' => true,'fetchpriority' => 'high','referrerpolicy' => 'origin'],
				['async' => 'async'],
				[]
			);
			$pars = $app->getDocument()->addScriptOptions('snippet',$refinedsample);
			$assetManager->useScript('plg.system.ccm19integration');
		}

	}

	/**
	 * getIntegrationUrl
	 *
	 * @param $snippet
	 *
	 * @return string|null
	 *
	 * @since 1.0
	 */
	private function getIntegrationUrl($snippet): ?string
	{

		if ( ! empty( $snippet ) ) {
			$match = [];
			preg_match( '/\bsrc=([\'"])((?>[^"\'?#]|(?!\1)["\'])*\/(ccm19|app)\.js\?(?>[^"\']|(?!\1).)*)\1/i', $snippet, $match );
			if ( $match and $match[2] ) {
				return html_entity_decode( $match[2], ENT_HTML401 | ENT_QUOTES, 'UTF-8' );
			}
		}
		return null;
	}
}
