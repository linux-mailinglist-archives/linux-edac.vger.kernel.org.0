Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213FB118F46
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 18:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLJRtZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Dec 2019 12:49:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:31791 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfLJRtZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Dec 2019 12:49:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 09:30:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="215642261"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2019 09:30:43 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [Bisected] altera_edac crash on a system without ECC
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20191129165739.GA2583@ak-laptop.emea.nsn-net.net>
 <3bbd2890-ffcc-39df-8ab6-ecf72d92a006@linux.intel.com>
 <20191204132531.GA22600@ak-laptop.emea.nsn-net.net>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <f9634662-23b0-7ec7-aed5-754bd5dc81b8@linux.intel.com>
Date:   Tue, 10 Dec 2019 11:32:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204132531.GA22600@ak-laptop.emea.nsn-net.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Aaro,

On 12/4/19 7:25 AM, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Dec 03, 2019 at 05:09:48PM -0600, Thor Thayer wrote:
>> On 11/29/19 10:57 AM, Aaro Koskinen wrote:
>>> Hi,
>>>
>>> I tried booting v5.4 mainline kernel on a stratix10 board with ECC
>>> disabled, and the altera-edac driver (with only SDRAM enabled) is
>>> now crashing the system instead of failing the probe with "No ECC/ECC
>>> disabled".
>>>
>> I apologize for the late reply. I was on vacation.
>>
>> ECC disabled means the sof/jic that you're loading has ECC disabled,
>> correct?
> 
> Yes.
> 
>>> This seems to have started with commit 08f08bfb7b4c ("EDAC, altera:
>>> Merge Stratix10 into the Arria10 SDRAM probe routine"). With the change,
>>> looks like sdram probe no longer uses SMC calls and instead accesses
>>> the registers directly. The crash looks like this:
>>
>> I haven't seen this. I'd expect both ECC enabled and disabled to fail with
>> the dumps you have below since they'd both need to use the regmap functions.
> 
> With ECC enabled it doesn't fail, as the direct register access appears
> to work then (I also checked by reading 0xf8011101 from userspace -
> and it works without an abort).
> 
>> Yes, this does look like it is using the register accesses instead of the
>> SMC call. Line 2206 sets the SMC call after determining from the if()
>> statement if it is a Stratix10 or Arria10 and from below it seems to take
>> the Arria10 path.
> 
> But that's setting the ecc_mgr_map. I think that altr_check_ecc_deps
> and altr_sdram_probe use a different mapping. Before commit 08f08bfb7b4c
> there was S10 specific altr_s10_sdram_probe() that took care of the SMC,
> but I cannot see how the current code doing that unless I'm missing some
> special magic.
> 
>> The altr_check_ecc_deps() call is checking whether ECC is enabled so the
>> probe should fail.
>>
>> I suspect the device tree. Can you verify the following node is in your
>> device tree?
>>
>> 	sdramedac {
>> 		compatible = "altr,sdram-edac-s10";
>> 		altr,sdr-syscon = <&sdr>;
>> 		interrupts = <16 4>;
>> 	};
> 
> Yes, I'm using the in-tree socfpga_stratix10.dtsi.
> 
> A.
> 
This appears to be a setup problem in U-Boot where U-Boot only allows 
access to the ECC registers if ECC is enabled. However, the Linux EDAC 
driver reads the ECC registers to determine if ECC is enabled or not.

A patch that always allows access to the ECC registers has been posted 
to U-Boot.
https://patchwork.ozlabs.org/patch/1205274/

Thanks,

Thor

