Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCD2F05A4
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbhAJGMV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 10 Jan 2021 01:12:21 -0500
Received: from forward104j.mail.yandex.net ([5.45.198.247]:52520 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbhAJGMV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Sun, 10 Jan 2021 01:12:21 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 01:12:21 EST
Received: from iva1-12e7d973dd36.qloud-c.yandex.net (iva1-12e7d973dd36.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:928c:0:640:12e7:d973])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 922E64A1942
        for <linux-edac@vger.kernel.org>; Sun, 10 Jan 2021 09:03:25 +0300 (MSK)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
        by iva1-12e7d973dd36.qloud-c.yandex.net (mxback/Yandex) with ESMTP id D0FQ6CuveC-3PEGaCZ4;
        Sun, 10 Jan 2021 09:03:25 +0300
Authentication-Results: iva1-12e7d973dd36.qloud-c.yandex.net; dkim=pass
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id TNLCPPWFSG-3OImx1a6;
        Sun, 10 Jan 2021 09:03:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     linux-edac@vger.kernel.org
From:   WGH <wgh@torlan.ru>
Subject: Unable to set (or read back) sdram_scrub_rate on amd64_edac F17h_M70h
 (Ryzen 3rd gen)
Message-ID: <a9cdf7c2-868a-8f67-ac4e-c6bff60552e2@torlan.ru>
Date:   Sun, 10 Jan 2021 09:03:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I tried many rates mentioned in scrubrates[] array, but the result is still the same.

% echo 100000 | sudo tee /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
100000
% sudo cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
0

dmesg excerpt:

[    0.561809] EDAC MC: Ver: 3.0.0
(skip)
[    0.825762] EDAC amd64: F17h_M70h detected (node 0).
[    0.826343] EDAC amd64: Node 0: DRAM ECC enabled.
[    0.826901] EDAC amd64: MCT channel count: 2
[    0.827512] EDAC MC0: Giving out device to module amd64_edac controller F17h_M70h: DEV 0000:00:18.3 (INTERRUPT)
[    0.828106] EDAC MC: UMC0 chip selects:
[    0.828106] EDAC amd64: MC: 0: 16384MB 1: 16384MB
[    0.828690] EDAC amd64: MC: 2: 16384MB 3: 16384MB
[    0.829262] EDAC MC: UMC1 chip selects:
[    0.829262] EDAC amd64: MC: 0: 16384MB 1: 16384MB
[    0.829829] EDAC amd64: MC: 2: 16384MB 3: 16384MB
[    0.830383] EDAC amd64: using x16 syndromes.
[    0.830992] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
[    0.831577] AMD64 EDAC driver v3.5.0

This is AMD Ryzen 9 3900XT on ASRock B550 Extreme4 motherboard, Linux 5.10.5.


