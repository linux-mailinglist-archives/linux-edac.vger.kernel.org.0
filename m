Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28C523C1E
	for <lists+linux-edac@lfdr.de>; Wed, 11 May 2022 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbiEKSA2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 May 2022 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbiEKSAI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 May 2022 14:00:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BCC6FD01;
        Wed, 11 May 2022 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652292005; x=1683828005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ea+lYRPzihmO8EVmbnlP0uLWZcsNp5NT/ZPU0VZFjGk=;
  b=Ozsb0R+HKLUH0PPr6szmm0OSRc+17gnBRn99+Yog4JYInkc909fTlSid
   4ovbTzdKa2pE5K8oir7ufZ7NRJrsRBNDK41/rYEmGi5MuzZ80webNVNZw
   P87MzHJxi9FCI7MeSuFOKaZu3yB3fAL3hudmRpzbmXndJ2oFPcBjE7UF/
   RapinTMEDrYnpN6LBFW6pkTpWw3fWm3+qP731MiNMptkuOanlQ4ZKhER8
   h3kUL4udz3AA9aEniN5In/6hopmvHlkcUnK7/hAERko3WktEswGliu4JK
   23OawPeXLLP4Mx5hCsKYPeMftDkrFhpTGWPFNgURLqcnIWB2gnhsmX4Nj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295014431"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="295014431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="711586936"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2022 11:00:02 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noqd0-000JNw-1P;
        Wed, 11 May 2022 18:00:02 +0000
Date:   Thu, 12 May 2022 01:59:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linmq006@gmail.com
Subject: Re: [PATCH] EDAC: Fix some refcount leaks
Message-ID: <202205120119.sArUU4SY-lkp@intel.com>
References: <20220511081402.19784-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511081402.19784-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Miaoqian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ras/edac-for-next]
[also build test ERROR on linux/master linus/master v5.18-rc6 next-20220511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaoqian-Lin/EDAC-Fix-some-refcount-leaks/20220511-161440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205120119.sArUU4SY-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e5e3d8b94764dd1abe3c99881483c3f6dee8030a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miaoqian-Lin/EDAC-Fix-some-refcount-leaks/20220511-161440
        git checkout e5e3d8b94764dd1abe3c99881483c3f6dee8030a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/edac/edac_device_sysfs.c: In function 'edac_device_create_instance':
>> drivers/edac/edac_device_sysfs.c:640:17: error: label 'edac_device_create_instance' used but not defined
     640 |                 goto edac_device_create_instance;
         |                 ^~~~


vim +/edac_device_create_instance +640 drivers/edac/edac_device_sysfs.c

   604	
   605	/*
   606	 * edac_device_create_instance
   607	 *	create just one instance of an edac_device 'instance'
   608	 */
   609	static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
   610					int idx)
   611	{
   612		int i, j;
   613		int err;
   614		struct edac_device_instance *instance;
   615		struct kobject *main_kobj;
   616	
   617		instance = &edac_dev->instances[idx];
   618	
   619		/* Init the instance's kobject */
   620		memset(&instance->kobj, 0, sizeof(struct kobject));
   621	
   622		instance->ctl = edac_dev;
   623	
   624		/* bump the main kobject's reference count for this controller
   625		 * and this instance is dependent on the main
   626		 */
   627		main_kobj = kobject_get(&edac_dev->kobj);
   628		if (!main_kobj) {
   629			err = -ENODEV;
   630			goto err_out;
   631		}
   632	
   633		/* Formally register this instance's kobject under the edac_device */
   634		err = kobject_init_and_add(&instance->kobj, &ktype_instance_ctrl,
   635					   &edac_dev->kobj, "%s", instance->name);
   636		if (err != 0) {
   637			edac_dbg(2, "Failed to register instance '%s'\n",
   638				 instance->name);
   639			kobject_put(main_kobj);
 > 640			goto edac_device_create_instance;
   641		}
   642	
   643		edac_dbg(4, "now register '%d' blocks for instance %d\n",
   644			 instance->nr_blocks, idx);
   645	
   646		/* register all blocks of this instance */
   647		for (i = 0; i < instance->nr_blocks; i++) {
   648			err = edac_device_create_block(edac_dev, instance,
   649							&instance->blocks[i]);
   650			if (err) {
   651				/* If any fail, remove all previous ones */
   652				for (j = 0; j < i; j++)
   653					edac_device_delete_block(edac_dev,
   654								&instance->blocks[j]);
   655				goto err_release_instance_kobj;
   656			}
   657		}
   658		kobject_uevent(&instance->kobj, KOBJ_ADD);
   659	
   660		edac_dbg(4, "Registered instance %d '%s' kobject\n",
   661			 idx, instance->name);
   662	
   663		return 0;
   664	
   665		/* error unwind stack */
   666	err_release_instance_kobj:
   667		kobject_put(&instance->kobj);
   668	
   669	err_out:
   670		return err;
   671	}
   672	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
