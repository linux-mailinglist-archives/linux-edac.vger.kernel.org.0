Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23C2B9EA4
	for <lists+linux-edac@lfdr.de>; Sat, 21 Sep 2019 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404170AbfIUPWb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Sep 2019 11:22:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:63700 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404347AbfIUPWb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 21 Sep 2019 11:22:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2019 08:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,532,1559545200"; 
   d="gz'50?scan'50,208,50";a="200013335"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.135])
  by orsmga002.jf.intel.com with ESMTP; 21 Sep 2019 08:22:15 -0700
Date:   Sat, 21 Sep 2019 23:28:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     kbuild-all@01.org, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com
Subject: Re: [PATCH v3 1/2] edac: Add an API for edac device to report for
 multiple errors
Message-ID: <20190921152808.GI13091@xsang-OptiPlex-9020>
Reply-To: kbuild test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <20190919171713.8060-2-hhhawa@amazon.com>
user-agent: NeoMutt/20170113 (1.7.2)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hanna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3 next-20190919]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Hanna-Hawa/Add-an-API-for-edac-device-for-mulriple-errors/20190920-012316
reproduce: make htmldocs
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1811: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
>> drivers/edac/edac_device.h:332: warning: Function parameter or member 'count' not described in '__edac_device_handle_ue'
   drivers/edac/edac_device.h:332: warning: Excess function parameter 'error_count' description in '__edac_device_handle_ue'
>> drivers/edac/edac_device.h:345: warning: Function parameter or member 'count' not described in '__edac_device_handle_ce'
   drivers/edac/edac_device.h:345: warning: Excess function parameter 'error_count' description in '__edac_device_handle_ce'
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
   fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
   drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
   mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:823: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'

# https://github.com/0day-ci/linux/commit/a424d1ea95bc2f0f1a6f3c8bd097f62c23832281
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout a424d1ea95bc2f0f1a6f3c8bd097f62c23832281
vim +332 drivers/edac/edac_device.h

6d8ef2472410c8 Mauro Carvalho Chehab 2016-10-29  319  
a424d1ea95bc2f Hanna Hawa            2019-09-19  320  /**
a424d1ea95bc2f Hanna Hawa            2019-09-19  321   * __edac_device_handle_ue():
a424d1ea95bc2f Hanna Hawa            2019-09-19  322   *	perform a common output and handling of an 'edac_dev' UE event
a424d1ea95bc2f Hanna Hawa            2019-09-19  323   *
a424d1ea95bc2f Hanna Hawa            2019-09-19  324   * @edac_dev: pointer to struct &edac_device_ctl_info
a424d1ea95bc2f Hanna Hawa            2019-09-19  325   * @error_count: number of errors of the same type
a424d1ea95bc2f Hanna Hawa            2019-09-19  326   * @inst_nr: number of the instance where the UE error happened
a424d1ea95bc2f Hanna Hawa            2019-09-19  327   * @block_nr: number of the block where the UE error happened
a424d1ea95bc2f Hanna Hawa            2019-09-19  328   * @msg: message to be printed
a424d1ea95bc2f Hanna Hawa            2019-09-19  329   */
a424d1ea95bc2f Hanna Hawa            2019-09-19  330  void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
a424d1ea95bc2f Hanna Hawa            2019-09-19  331  				    unsigned int count, int inst_nr,
a424d1ea95bc2f Hanna Hawa            2019-09-19 @332  				    int block_nr, const char *msg);
a424d1ea95bc2f Hanna Hawa            2019-09-19  333  /**
a424d1ea95bc2f Hanna Hawa            2019-09-19  334   * __edac_device_handle_ce():
a424d1ea95bc2f Hanna Hawa            2019-09-19  335   *	perform a common output and handling of an 'edac_dev' CE event
a424d1ea95bc2f Hanna Hawa            2019-09-19  336   *
a424d1ea95bc2f Hanna Hawa            2019-09-19  337   * @edac_dev: pointer to struct &edac_device_ctl_info
a424d1ea95bc2f Hanna Hawa            2019-09-19  338   * @error_count: number of errors of the same type
a424d1ea95bc2f Hanna Hawa            2019-09-19  339   * @inst_nr: number of the instance where the CE error happened
a424d1ea95bc2f Hanna Hawa            2019-09-19  340   * @block_nr: number of the block where the CE error happened
a424d1ea95bc2f Hanna Hawa            2019-09-19  341   * @msg: message to be printed
a424d1ea95bc2f Hanna Hawa            2019-09-19  342   */
a424d1ea95bc2f Hanna Hawa            2019-09-19  343  void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
a424d1ea95bc2f Hanna Hawa            2019-09-19  344  				    unsigned int count, int inst_nr,
a424d1ea95bc2f Hanna Hawa            2019-09-19 @345  				    int block_nr, const char *msg);
a424d1ea95bc2f Hanna Hawa            2019-09-19  346  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tctmm6wHVGT/P6vA
Content-Type: application/gzip; name=".config.gz"
Content-Description: .config.gz
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tctmm6wHVGT/P6vA--
