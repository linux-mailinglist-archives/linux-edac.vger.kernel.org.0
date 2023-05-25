Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2E7111DE
	for <lists+linux-edac@lfdr.de>; Thu, 25 May 2023 19:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbjEYRSb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 May 2023 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbjEYRS2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 May 2023 13:18:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD2195;
        Thu, 25 May 2023 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685035105; x=1716571105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fx5cirxrz+HpUTDvn+zJBzDpeIbw64NeczyJDswoBq4=;
  b=eR+dyxtogv3qdq0CT8QoYKxHY3FW8sXasXZPssoaCkn+97irSL3ATdrn
   W4q808IrJVH93oHilrzgdEbX3uf9sl2YYHI6n5FL3nCwPyRuuidrZQy2g
   GRr+XWBSPypI06nHsdHejjTCLsxpktOxmGlWsoD9b9ZwCnodBYiLaok4S
   hjOv0iVr1YWR6y8deBmUMeVyfZo+IqX6KdTfNmlkS1GcCafFcMhrtIUny
   8U0CiuMGPKQi2DNjzbpc8SjtCt9qrZW8QJGwEZNzj3fxHP0FT/9IjHiEB
   rPq4385YrvD9ljgnG2wyTFIxH3NvhnWCkICLhEtO0tfA4JK4hTlZkOI6w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="357206470"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="357206470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 10:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="704871231"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="704871231"
Received: from shuklaas-mobl1.amr.corp.intel.com (HELO [10.212.186.148]) ([10.212.186.148])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 10:18:23 -0700
Message-ID: <5570c23a-3b12-6685-cb0b-29fc1d58f541@intel.com>
Date:   Thu, 25 May 2023 10:18:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jane.chu@oracle.com
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/7/23 19:22, Kefeng Wang wrote:
> Both EX_TYPE_FAULT_MCE_SAFE and EX_TYPE_DEFAULT_MCE_SAFE exception
> fixup types are used to identify fixups which allow in kernel #MC
> recovery, that is the Machine Check Safe Copy.
> 
> For now, the MCE_IN_KERNEL_COPYIN flag is only set for EX_TYPE_COPY
> and EX_TYPE_UACCESS when copy from user, and corrupted page is
> isolated in this case, for MC-safe copy, memory_failure() is not
> always called, some places, like __wp_page_copy_user, copy_subpage,
> copy_user_gigantic_page and ksm_might_need_to_copy manually call
> memory_failure_queue() to cope with such unhandled error pages,
> recently coredump hwposion recovery support[1] is asked to do the
> same thing, and there are some other already existed MC-safe copy
> scenarios, eg, nvdimm, dm-writecache, dax, which has similar issue.

That has to set some kind of record for run-on sentences.  Could you
please try to rewrite this coherently?

> The best way to fix them is set MCE_IN_KERNEL_COPYIN to MCE_SAFE
> exception, then kill_me_never() will be queued to call memory_failure()
> in do_machine_check() to isolate corrupted page, which avoid calling
> memory_failure_queue() after every MC-safe copy return.

Could you try to send a v2 of this with a clear problem statement?

What is the end user visible effect of the problem and of your solution?
