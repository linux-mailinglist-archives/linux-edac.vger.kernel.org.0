Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5631B6C72B2
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 23:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCWWBb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWWB3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 18:01:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48F1969A;
        Thu, 23 Mar 2023 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679608884; x=1711144884;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8ZO0KUFqDoKAcKuJnD80dD4sOMVCx3/gRnn8LiNdXqc=;
  b=hCE6MuotLASW1t73DNr0qSXosD5W0zbO5NQjQK07go1laRbl1aPmZ/SA
   g22DZVGc7i1xTKuO6tkf71K8zVTjr8xaDIwsGUn3tPwf7H6MJ1IDaA4Cl
   PlAPa7Yo4vbd+H746vFPQOpupS8C7JxNETjJfZ29HMmiyMrKvPN/GqAUk
   fWjpfSFPSCeq80yEW0b4h8bch2cx298cUatxe1H5nANDWGpyOWmNl7VeY
   mlO0mnGeO11mX+VISt/url2fwfImqwcEs9mXZae0VQJgRi8oj7Ct4b0w3
   sO+zH0ZPsG6aVbJ5wj2evaQ4v6cMyoDkLNz3l2p6rF1O9grC2bGVvXzvW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="342018362"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="342018362"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="684921802"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="684921802"
Received: from jball6-mobl.amr.corp.intel.com (HELO [10.209.105.116]) ([10.209.105.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:01:22 -0700
Message-ID: <f3a47826-881f-6542-5db2-63ebf1705cb6@intel.com>
Date:   Thu, 23 Mar 2023 15:01:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Content-Language: en-US
To:     "Meyer, Kyle" <kyle.meyer@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20230323202158.37937-1-kyle.meyer@hpe.com>
 <7d9679e9-6d1a-bb08-dbcc-acb833bd5fd8@intel.com>
 <MW5PR84MB171359C71BF003E287E2323C9B879@MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <MW5PR84MB171359C71BF003E287E2323C9B879@MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 3/23/23 14:52, Meyer, Kyle wrote:
>> Also, why *should* these be part of the stable sysfs ABI?  What app is
>> using them?  Why does it need them?
> We have system scripts that adjust decay_interval and action_threshold.
> They can't access those attributes when lockdown is enabled. If there is a
> more appropriate place for those attributes, please let me know.

Thanks for the info.  That helps a bit.  But, I'd also appreciate if you
could expand on this a little more.  What "system scripts" are these?
Who is using them?  What are they trying to accomplish?

We can try to find the best home for these attributes with that info in
hand, if it's not sysfs.

>> Why these two and only these two? What's left in debugfs?
> The other attributes (pfn and array) are used to test CEC. They are only
> created when RAS_CEC_DEBUG is enabled.

Oh, that's good info too.  Can you please include that in some form in
your new changelog?
