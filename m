Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936D7556EA0
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jun 2022 00:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiFVWmk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jun 2022 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiFVWmk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jun 2022 18:42:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66741302;
        Wed, 22 Jun 2022 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655937759; x=1687473759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wAI3HgZDn19wBnHx36VJXsDEl9XOn1bfnAvHgA6urTI=;
  b=Mu1OmF40FAZyt0U6ov6IlAe/QtHfW9bGWr50kFKGzeoipujsIY4k936B
   Rkq4nTPBis64RyAtx5a8+msmlikrOeQFColmH/xtmo8T36t943EcUeUXU
   baa7dgVtuzimJWAGAWfcVp4EI2fORIXAYbXuet9E4H7ZVPCHpJzMEzNM1
   PzlmRGCkQLMHm8lQRTDKtDPIEhc0OT0/LFkimHUowYA8Dl3fwWAqogBM5
   IG30efou8TdmbytVuo05SI06f6lIAt0tSPQS1mqq90/0eRj2Nod17ZwN0
   lKWtaiIsq/ofsH1ydQWnISWFqdwlVzdHgPvZItgaqUzTdMcALscLv6q6X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344554134"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344554134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="538662076"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 15:42:37 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o493U-0001lp-Af;
        Wed, 22 Jun 2022 22:42:36 +0000
Date:   Thu, 23 Jun 2022 06:42:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de,
        linux-edac@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] EDAC/amd64: Include MCA error codes in EDAC message
Message-ID: <202206230649.5mB3KFtF-lkp@intel.com>
References: <20220622160800.1293328-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622160800.1293328-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Yazen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazen-Ghannam/EDAC-amd64-Include-MCA-error-codes-in-EDAC-message/20220623-001158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230649.5mB3KFtF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f791cdde2f3ca52076ed5d1185138b80d4d783bf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yazen-Ghannam/EDAC-amd64-Include-MCA-error-codes-in-EDAC-message/20220623-001158
        git checkout f791cdde2f3ca52076ed5d1185138b80d4d783bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/edac/amd64_edac.c: In function '__log_ecc_error':
>> drivers/edac/amd64_edac.c:3179:13: warning: variable 'len' set but not used [-Wunused-but-set-variable]
    3179 |         int len;
         |             ^~~


vim +/len +3179 drivers/edac/amd64_edac.c

  3173	
  3174	static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
  3175				    u8 ecc_type)
  3176	{
  3177		enum hw_event_mc_err_type err_type;
  3178		const char *string;
> 3179		int len;
  3180	
  3181		if (ecc_type == 2)
  3182			err_type = HW_EVENT_ERR_CORRECTED;
  3183		else if (ecc_type == 1)
  3184			err_type = HW_EVENT_ERR_UNCORRECTED;
  3185		else if (ecc_type == 3)
  3186			err_type = HW_EVENT_ERR_DEFERRED;
  3187		else {
  3188			WARN(1, "Something is rotten in the state of Denmark.\n");
  3189			return;
  3190		}
  3191	
  3192		switch (err->err_code) {
  3193		case DECODE_OK:
  3194			string = "";
  3195			break;
  3196		case ERR_NODE:
  3197			string = "Failed to map error addr to a node";
  3198			break;
  3199		case ERR_CSROW:
  3200			string = "Failed to map error addr to a csrow";
  3201			break;
  3202		case ERR_CHANNEL:
  3203			string = "Unknown syndrome - possible error reporting race";
  3204			break;
  3205		case ERR_SYND:
  3206			string = "MCA_SYND not valid - unknown syndrome and csrow";
  3207			break;
  3208		case ERR_NORM_ADDR:
  3209			string = "Cannot decode normalized address";
  3210			break;
  3211		default:
  3212			string = "WTF error";
  3213			break;
  3214		}
  3215	
  3216		len = snprintf(msg, MSG_SIZE, "err_code:0x%04x:0x%04x", err->xec, err->ec);
  3217	
  3218		edac_mc_handle_error(err_type, mci, 1,
  3219				     err->page, err->offset, err->syndrome,
  3220				     err->csrow, err->channel, -1,
  3221				     string, msg);
  3222	}
  3223	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
