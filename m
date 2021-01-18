Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1162F975C
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jan 2021 02:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbhARBbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 17 Jan 2021 20:31:45 -0500
Received: from forward105j.mail.yandex.net ([5.45.198.248]:59882 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730365AbhARBbo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Sun, 17 Jan 2021 20:31:44 -0500
Received: from iva5-92838732ac93.qloud-c.yandex.net (iva5-92838732ac93.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:5c9c:0:640:9283:8732])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 52625B20741;
        Mon, 18 Jan 2021 04:30:59 +0300 (MSK)
Received: from iva7-f62245f79210.qloud-c.yandex.net (iva7-f62245f79210.qloud-c.yandex.net [2a02:6b8:c0c:2e83:0:640:f622:45f7])
        by iva5-92838732ac93.qloud-c.yandex.net (mxback/Yandex) with ESMTP id GF9SUY9yCP-UxDq7JBb;
        Mon, 18 Jan 2021 04:30:59 +0300
Authentication-Results: iva5-92838732ac93.qloud-c.yandex.net; dkim=pass
Received: by iva7-f62245f79210.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id V9qGMnUq0m-UwImY3db;
        Mon, 18 Jan 2021 04:30:58 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        Smita.KoralahalliChannabasappa@amd.com
References: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
From:   WGH <wgh@torlan.ru>
Subject: Re: [PATCH] EDAC/AMD64: Update scrub register addresses for newer
 models
Message-ID: <f171c29f-5c89-683c-8cf2-399c9af5153e@torlan.ru>
Date:   Mon, 18 Jan 2021 04:30:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16/01/2021 17:33, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> The Family 17h scrubber registers moved to different offset starting
> with Model 30h. The new register offsets are used for all currently
> available models since then.
>
> Use the new register addresses as the defaults.
>
> Set the proper scrub register addresses during module init for older
> models.

So I tested the patch on my machine (AMD Ryzen 9 3900XT on ASRock B550 Extreme4 motherboard, Linux 5.10.7).

The /sys/devices/system/edac/mc/mc0/sdram_scrub_rate value seems to be stuck at 12284069 right after the boot, and does not change.
Writes to the file do not report any errors.

dmesg:

[    0.549451] EDAC MC: Ver: 3.0.0
[    0.817576] EDAC amd64: F17h_M70h detected (node 0).
[    0.818159] EDAC amd64: Node 0: DRAM ECC enabled.
[    0.818717] EDAC amd64: MCT channel count: 2
[    0.819324] EDAC MC0: Giving out device to module amd64_edac controller F17h_M70h: DEV 0000:00:18.3 (INTERRUPT)
[    0.819909] EDAC MC: UMC0 chip selects:
[    0.819910] EDAC amd64: MC: 0: 16384MB 1: 16384MB
[    0.820488] EDAC amd64: MC: 2: 16384MB 3: 16384MB
[    0.821067] EDAC MC: UMC1 chip selects:
[    0.821067] EDAC amd64: MC: 0: 16384MB 1: 16384MB
[    0.821630] EDAC amd64: MC: 2: 16384MB 3: 16384MB
[    0.822187] EDAC amd64: using x16 syndromes.
[    0.822739] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
[    0.823314] AMD64 EDAC driver v3.5.0


