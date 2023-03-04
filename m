Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401D6AA7D4
	for <lists+linux-edac@lfdr.de>; Sat,  4 Mar 2023 04:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCDDb5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Mar 2023 22:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDb4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Mar 2023 22:31:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481D1717;
        Fri,  3 Mar 2023 19:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677900715; x=1709436715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lC00a7QDvJed45Tjn97fOVsXMY/DvRnzQH44GylGkVo=;
  b=WehblqwStfcOFO6OaBeuVjPZYyGnAJq0y9C8o7M7d4788c5g4rSVHNpu
   p+RuAQKNzz+grvvCaFFtOkfumFci17qHS4scOlSlQtS7yAcLSm7kagBHI
   EHBV3H58PM8TWgfqf4t9BPqUvxG1COIKg4HOWf3XiOm7MjQwpRhlwmFd/
   6WFr+RfCGFeO2pDWPr9LGbR4Vz87mkgCacQKakFxB79F/9EP5NvWFjVX0
   0HIsHHFFITSrJFSXXJ4Hz+7aHkrnzRZTucWsTh4dvttg7L6b34iLS2njQ
   FFxskdK2M5kmdQIC/+PNiELAy4TYRP4b1N1DItITlTUgoW9kYmnX1r763
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="335240484"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="335240484"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 19:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="652994789"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="652994789"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 19:31:52 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Kamati Srinivas <quic_kamasrin@quicinc.com>
Cc:     James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_stummala@quicinc.com
Subject: RE: [PATCH 0/2] edac: Add support to handle Deferred Error
Date:   Sat,  4 Mar 2023 11:30:21 +0800
Message-Id: <20230304033021.35896-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230303125408.26971-1-quic_kamasrin@quicinc.com>
References: <20230303125408.26971-1-quic_kamasrin@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> From: Kamati Srinivas <quic_kamasrin@quicinc.com>
> ...
>
> This patchset adds support to handle Deferred error, also

  It would be better if there is a use case showing some EDAC
  driver(s) needs this newly added "Deferred Error" code
  in the EDAC core.

  -Qiuxu

> cleans up the code for log_ue/ce and corresponding APIs.
> 
> Kamati Srinivas (2):
>   edac: Modify sysfs enabled values log_ue, log_ce to bool
>   edac: Add support to handle DE (Deferred Errors)
> 
>  drivers/edac/edac_device.c       | 57 ++++++++++++++++++++++++++++++--
>  drivers/edac/edac_device.h       | 34 +++++++++++++++++--
>  drivers/edac/edac_device_sysfs.c | 50 ++++++++++++++++++++++++----
>  3 files changed, 130 insertions(+), 11 deletions(-)
