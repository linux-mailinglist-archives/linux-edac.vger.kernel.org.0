Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E322F06C7
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 12:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbhAJLzf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 10 Jan 2021 06:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAJLze (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Jan 2021 06:55:34 -0500
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jan 2021 03:54:54 PST
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8BC061786
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 03:54:54 -0800 (PST)
Received: from iva5-6f7b67e4dbc7.qloud-c.yandex.net (iva5-6f7b67e4dbc7.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:699:0:640:6f7b:67e4])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id A053D1C81868;
        Sun, 10 Jan 2021 14:46:53 +0300 (MSK)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
        by iva5-6f7b67e4dbc7.qloud-c.yandex.net (mxback/Yandex) with ESMTP id SF3hHtFktZ-krFWJUgZ;
        Sun, 10 Jan 2021 14:46:53 +0300
Authentication-Results: iva5-6f7b67e4dbc7.qloud-c.yandex.net; dkim=pass
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3oIDIrKe3Q-kqI8jYdv;
        Sun, 10 Jan 2021 14:46:52 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org
References: <a9cdf7c2-868a-8f67-ac4e-c6bff60552e2@torlan.ru>
 <20210110113308.GB22211@zn.tnic>
From:   WGH <wgh@torlan.ru>
Subject: Re: Unable to set (or read back) sdram_scrub_rate on amd64_edac
 F17h_M70h (Ryzen 3rd gen)
Message-ID: <a7e91287-cb0c-7d40-fa9c-c87d9692f229@torlan.ru>
Date:   Sun, 10 Jan 2021 14:46:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210110113308.GB22211@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/10/21 2:33 PM, Borislav Petkov wrote:
> On Sun, Jan 10, 2021 at 09:03:24AM +0300, WGH wrote:
>> I tried many rates mentioned in scrubrates[] array, but the result is still the same.
>>
>> % echo 100000 | sudo tee /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
>> 100000
>> % sudo cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
>> 0
>>
>> dmesg excerpt:
>>
>> [    0.561809] EDAC MC: Ver: 3.0.0
>> (skip)
>> [    0.825762] EDAC amd64: F17h_M70h detected (node 0).
>> [    0.826343] EDAC amd64: Node 0: DRAM ECC enabled.
>> [    0.826901] EDAC amd64: MCT channel count: 2
>> [    0.827512] EDAC MC0: Giving out device to module amd64_edac controller F17h_M70h: DEV 0000:00:18.3 (INTERRUPT)
>> [    0.828106] EDAC MC: UMC0 chip selects:
>> [    0.828106] EDAC amd64: MC: 0: 16384MB 1: 16384MB
>> [    0.828690] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>> [    0.829262] EDAC MC: UMC1 chip selects:
>> [    0.829262] EDAC amd64: MC: 0: 16384MB 1: 16384MB
>> [    0.829829] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>> [    0.830383] EDAC amd64: using x16 syndromes.
>> [    0.830992] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
>> [    0.831577] AMD64 EDAC driver v3.5.0
>>
>> This is AMD Ryzen 9 3900XT on ASRock B550 Extreme4 motherboard, Linux 5.10.5.
> That thing checks a bit 0 in some PCI cfg reg on F17h before returning
> the scrubrate. Do as root:
>
> # setpci -s 00:18.6 0x0x48.l
% sudo setpci  -s 00:18.6 0x48.l
b214bac4
% sudo setpci  -s 00:18.6 0x48.l
b23225c4
% sudo setpci  -s 00:18.6 0x48.l
b2648984
% sudo setpci  -s 00:18.6 0x48.l
b27b9dc4
% sudo setpci  -s 00:18.6 0x48.l
b293f504

Whatever that means.

>
> It could be that scrub rate setting is locked on your machine. Because
> it works here:
>
> # echo 100000 > /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
> # cat  /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
> 390720
>
> That's a AMD Ryzen 7 2700X Eight-Core Processor, however.
>
> Yazen?
>


