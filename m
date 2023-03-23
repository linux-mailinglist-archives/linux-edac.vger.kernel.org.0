Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E306C71AB
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCWU3x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWU3x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 16:29:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB586A69;
        Thu, 23 Mar 2023 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679603392; x=1711139392;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3Be8DLFhUiGz0Q4pewR0vmSEASkcf3SAtExbAdhW4qY=;
  b=GfnqPAGSlkwybbhAk4S1U1xxSpMU0JhM0tyLYOKokf+v6MYe5qgtIwKk
   SxPIkFc4wfjt3ZK+Hr+K2bF1Bk1r74UnbG+tx9O7tkY8/PBxlkMuZ1LYd
   ts83k8lUKEkJQ7FmaU5G70mu7kdwSDUEaawRFPKuRp0u/2BRmhFeLJNnT
   MPQXI5sXghrqKCNJur4GomYMWkCNku0F+Lo6oKTWCD3ur7bVrb5Z03jQ2
   npCdWyeqaZAT8IKt5W3iuFUr8uc/N63rhAwdFAqHVwxu2shFJaFngjQaJ
   sPE2T2T5fmGvxpi1mVl5qckon3uviV4Z1QPh99JX/hecp43hbO0yMvbNe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341173788"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341173788"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 13:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="825965412"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="825965412"
Received: from jball6-mobl.amr.corp.intel.com (HELO [10.209.105.116]) ([10.209.105.116])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 13:29:51 -0700
Message-ID: <7d9679e9-6d1a-bb08-dbcc-acb833bd5fd8@intel.com>
Date:   Thu, 23 Mar 2023 13:29:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Content-Language: en-US
To:     kyle-meyer <kyle.meyer@hpe.com>, dimitri.sivanich@hpe.com,
        steve.wahl@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
        yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <20230323202158.37937-1-kyle.meyer@hpe.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230323202158.37937-1-kyle.meyer@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/23/23 13:22, kyle-meyer wrote:
> From: Kyle Meyer <kyle.meyer@hpe.com>
> 
> When kernel lockdown is in effect, use of debugfs is not permitted. Move
> decay_interval and action_threshold out of debugfs, from debugfs/ras/cec
> to sysfs/system/devices/machinecheck/cec.

You forgot to attach the patch that you wrote that updates
Documentation/ABI/. ;)

Also, why *should* these be part of the stable sysfs ABI?  What app is
using them?  Why does it need them?  Why these two and only these two?
What's left in debugfs?
