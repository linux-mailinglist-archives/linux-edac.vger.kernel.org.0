Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6610C9FB
	for <lists+linux-edac@lfdr.de>; Thu, 28 Nov 2019 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfK1N7U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Nov 2019 08:59:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:22781 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK1N7U (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Nov 2019 08:59:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 05:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="gz'50?scan'50,208,50";a="409360808"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2019 05:59:16 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iaKKC-000B0v-Fi; Thu, 28 Nov 2019 21:59:16 +0800
Date:   Thu, 28 Nov 2019 21:58:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     kbuild-all@lists.01.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] EDAC: Store error type in struct
 edac_raw_error_desc
Message-ID: <201911281938.hIX9FVQf%lkp@intel.com>
References: <20191127215415.11230-4-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dcwkpesdaxobfw5a"
Content-Disposition: inline
In-Reply-To: <20191127215415.11230-4-rrichter@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


--dcwkpesdaxobfw5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Robert,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on next-20191128]
[cannot apply to v5.4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Robert-Richter/EDAC-Rework-core-and-ghes-drivers-part-two/20191128-060034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>> include/linux/edac.h:475: warning: Function parameter or member 'type' not described in 'edac_raw_error_desc'
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   kernel/dma/coherent.c:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
   fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
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
   include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'

vim +475 include/linux/edac.h

ddeb3547d48234 Mauro Carvalho Chehab 2011-03-04  440  
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  441  /**
e002075819d987 Mauro Carvalho Chehab 2016-10-28  442   * struct edac_raw_error_desc - Raw error report structure
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  443   * @grain:			minimum granularity for an error report, in bytes
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  444   * @error_count:		number of errors of the same type
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  445   * @top_layer:			top layer of the error (layer[0])
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  446   * @mid_layer:			middle layer of the error (layer[1])
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  447   * @low_layer:			low layer of the error (layer[2])
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  448   * @page_frame_number:		page where the error happened
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  449   * @offset_in_page:		page offset
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  450   * @syndrome:			syndrome of the error (or 0 if unknown or if
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  451   * 				the syndrome is not applicable)
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  452   * @msg:			error message
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  453   * @location:			location of the error
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  454   * @label:			label of the affected DIMM(s)
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  455   * @other_detail:		other driver-specific detail about the error
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  456   * @enable_per_layer_report:	if false, the error affects all layers
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  457   *				(typically, a memory controller error)
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  458   */
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  459  struct edac_raw_error_desc {
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  460  	char location[LOCATION_SIZE];
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  461  	char label[(EDAC_MC_LABEL_LEN + 1 + sizeof(OTHER_LABEL)) * EDAC_MAX_LABELS];
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  462  	long grain;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  463  
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  464  	u16 error_count;
d1d3068be3ed63 Robert Richter        2019-11-27  465  	enum hw_event_mc_err_type type;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  466  	int top_layer;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  467  	int mid_layer;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  468  	int low_layer;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  469  	unsigned long page_frame_number;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  470  	unsigned long offset_in_page;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  471  	unsigned long syndrome;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  472  	const char *msg;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  473  	const char *other_detail;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  474  	bool enable_per_layer_report;
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21 @475  };
c7ef7645544131 Mauro Carvalho Chehab 2013-02-21  476  

:::::: The code at line 475 was first introduced by commit
:::::: c7ef7645544131b0750478d1cf94cdfa945c809d edac: reduce stack pressure by using a pre-allocated buffer

:::::: TO: Mauro Carvalho Chehab <mchehab@redhat.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--dcwkpesdaxobfw5a
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dcwkpesdaxobfw5a--
