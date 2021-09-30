Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E471F41DBD7
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351636AbhI3OEd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 10:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351814AbhI3OEF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 10:04:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36ADB61440;
        Thu, 30 Sep 2021 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633010540;
        bh=0LHNHemELtyiGJYnwXmqlHpJyubLyRp92TIqcnNtJSg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CV831w0f3j7NNWnLxQEgi9ajfFekM7LDl7Wu2gjMJe6YSOELc5Ts+4lQfPITrK0eu
         bLB+UqVaN9X52kls0wke9eHpE4RdtipoTB++yVDunhpENU1hPajE0t/ZJ2VMM5Tyho
         TFwECotNHFsefuvgeaUM8mc0o6jfihHVICvnUHtvSQ36Afr7V2aTGIk/lodhUDoOgV
         ra55nLsBPpwNBc4VmeByhlB8JkTRhrr6NfWw5/hXYsRLWXjTnVgUYwqZVuIZ8QiHiJ
         fTv3ri3oN8UmItmyjMUh+ZESIIxIfzZED6EUb8WSO+DVnP7Cq/4KkPoJxoCMMbLQAo
         6qN7qcQvV6G3Q==
Subject: Re: [PATCHv3 2/3] EDAC/synopsys: add support for version 3 of the
 Synopsys EDAC DDR
To:     Borislav Petkov <bp@alien8.de>
Cc:     michal.simek@xilinx.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <20210928160423.271187-1-dinguyen@kernel.org>
 <20210928160423.271187-2-dinguyen@kernel.org> <YVWianHwt7P1LPY9@zn.tnic>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <203f5399-a8e0-70be-8b8b-782e6870143e@kernel.org>
Date:   Thu, 30 Sep 2021 09:02:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVWianHwt7P1LPY9@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/30/21 6:41 AM, Borislav Petkov wrote:
> On Tue, Sep 28, 2021 at 11:04:22AM -0500, Dinh Nguyen wrote:
>> @@ -899,6 +930,10 @@ static const struct of_device_id synps_edac_match[] = {
>>   		.compatible = "xlnx,zynqmp-ddrc-2.40a",
>>   		.data = (void *)&zynqmp_edac_def
>>   	},
>> +	{
>> +		.compatible = "snps,ddrc-3.80a",
> 
> WARNING: DT compatible string "snps,ddrc-3.80a" appears un-documented -- check ./Documentation/devicetree/bindings/
> #169: FILE: drivers/edac/synopsys_edac.c:934:
> +               .compatible = "snps,ddrc-3.80a",
> 

I'll send a follow-up patch to document this.

Dinh
