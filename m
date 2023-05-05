Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147F66F82D2
	for <lists+linux-edac@lfdr.de>; Fri,  5 May 2023 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjEEMXR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 5 May 2023 08:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjEEMXR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 5 May 2023 08:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08019D5F;
        Fri,  5 May 2023 05:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C454F61281;
        Fri,  5 May 2023 12:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC7C433D2;
        Fri,  5 May 2023 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683289395;
        bh=E8fY5gdYncckPUwHd26for2rWI0uOv8SZd7JgmJurXs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NoAC4Qn4NkOkzDIk5v+aeIrN+FDTsf8yUIxUZHrMCIwmWuolJH455ETVB8JM1wMJI
         +AkzyY16uddEgjBCpmZCJuxGUvNdRNeRns5W6Rt6X5A2NtDnRVwroukGGcmndMHulm
         ajLiIwMaegsJGVIHuDOx7Rbw5UEK/kvGLnCXJoS7xDL3M0ejC0bDEOFQcoF3mEZUXs
         1e+Fo5NzF6nBNivw3Ye3ntB0+sJMF5scPTDotS6btPkyttJO+vJBRbP38X8jodTzvD
         breP6TeADJ3f7xa9Kbclfs9xRZ6SJSB57i5u6HGmzpo/NhwEsznEXHan3Rx1c5LXV2
         4Hd1uJmKsqFNg==
Message-ID: <ecadf25b-972b-4a20-17df-a03fa7c2dd20@kernel.org>
Date:   Fri, 5 May 2023 07:23:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] firmware: stratix10-svc: Add command to get SEU
 error info
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org,
        tony.luck@intel.com
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
 <20230503101821.3342935-2-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230503101821.3342935-2-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 5/3/23 05:18, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Introduce a new command to get Single Event Upset Error information.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index a718f853d457..669e2b12be39 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -595,4 +595,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>   #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
>   
> +/**
> + * Request INTEL_SIP_SMC_READ_SEU_ERR
> + * Sync call to get Single Event Upsate Error information

s/Upsate/Upset

> + * SEU detects both corrected and uncorrected error
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_READ_SEU_ERR
> + * a1-7 not used
> + *
> + * Return status:
> + * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
> + *    INTEL_SIP_SMC_STATUS_ERROR
> + * a1 error count of response data
> + * a2 sector address of response data
> + * a3 error data
> + */
> +#define INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS 153
> +#define INTEL_SIP_SMC_READ_SEU_ERR \
> +		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS)
> +
>   #endif
