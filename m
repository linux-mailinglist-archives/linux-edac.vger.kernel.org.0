Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE6309FA2
	for <lists+linux-edac@lfdr.de>; Mon,  1 Feb 2021 01:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBAAIR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 31 Jan 2021 19:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhBAAIA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 31 Jan 2021 19:08:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC812C061573
        for <linux-edac@vger.kernel.org>; Sun, 31 Jan 2021 16:07:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kg20so21597807ejc.4
        for <linux-edac@vger.kernel.org>; Sun, 31 Jan 2021 16:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pmarks-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0eLo56GbbOQEWcRbyLNsYNAG4DPjrW+fOVigYq9vZ5I=;
        b=BxAAy2286rUkiEpV6htMzexnFgIO37Vxn/yVZPIEAy1N71SJD0JIyTNOz9/YdB0IdW
         KQqP+yd2Bb0q466XDht8M6Of/ylZGlHBmADW7IMhRjQxPZHBfBQer3KjFJvjXyHA3js8
         y1HvP2jSsstJv9HJN5StI/+nqI3uk9at7Gd2Yc/IutYweYt/9UNWih5p171aSW8sjNkd
         iBnSHR6sg/BI7tt+feEDZ8NrLPZ5JzbNV6q3m+cPaekExLVrUrbibjqkQMU60xDX9g5E
         Xsm4n5sXGlcycvPO9UWu3BYPBdkZdEBcf+O37hV+ycEwXDio3MilY4rmL49h9y5y36GS
         I9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0eLo56GbbOQEWcRbyLNsYNAG4DPjrW+fOVigYq9vZ5I=;
        b=hphHv2qsG/f/lWCCVUY4Hjql+SdqCaetX11YQxfGx4y+5udtvdFEPA3GFsWmL2bLEH
         ERRYo2VOjPXzIGlgD8sigPYxuRKITEkll6kLLurIB/O0aC57OeNS0cXQqSlp6Z3+qlGV
         bbF2VEBtwUmLxxDrS3vCQUmU0NLpmjiKDYenH0a65eEyZbMk/+mv0x9kKjIBsXFFU9Fe
         V5nufJadKqob3js1RdUWC2bg7zlwM0Ry9t7vOo3VgUjVuLlkzLICN4sY/UCYHpSoEVBP
         hs21sXUhujx+jEwNxpvCvLA6u4OlYDF0R5xtGBTOsrP+mNanV0oxiaHcbrqbWxxd4DUO
         p4iA==
X-Gm-Message-State: AOAM531pbERYeqYFVLeRz8w0klKJUOIeCg+jOU+3LfU9+mzUB0GIwPXT
        jWrEFQieJWC3+Qz4rfSxPnBjOhXU/CSV8+ulyLfpzC6rU5Q=
X-Google-Smtp-Source: ABdhPJzUvEyEmyA3ueeMlqT9W5xRS1TXt8hqz6kQkj3t/r1Pua0yHMmtla/aaqhrSKUQ23pLlw7MgvPktXiMr1Y9nMg=
X-Received: by 2002:a17:906:c954:: with SMTP id fw20mr14988469ejb.342.1612138038149;
 Sun, 31 Jan 2021 16:07:18 -0800 (PST)
MIME-Version: 1.0
From:   Paul Marks <paul@pmarks.net>
Date:   Sun, 31 Jan 2021 16:07:06 -0800
Message-ID: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
Subject: ie31200_edac missing PCI ID for i3-4370
To:     linux-edac@vger.kernel.org
Cc:     jbaron@akamai.com, bp@alien8.de, m.chehab@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I have an ASRock C226M WS with an i3-4370 CPU.

# lspci -vnn
00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
            DRAM Controller [8086:0c00] (rev 06)
        Subsystem: ASRock Incorporation 4th Gen Core Processor
            DRAM Controller [1849:0c00]
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: hsw_uncore

But edac-util doesn't work:

# edac-util -v
edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data in sysfs

I tried this ham-fisted patch:

# diff -u ./drivers/edac/ie31200_edac.c{.old,}
--- ./drivers/edac/ie31200_edac.c.old
+++ ./drivers/edac/ie31200_edac.c
@@ -58,7 +58,7 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
-#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918

And it seems happy now:

# lspci -vnn
00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
            DRAM Controller [8086:0c00] (rev 06)
        Subsystem: ASRock Incorporation 4th Gen Core Processor
            DRAM Controller [1849:0c00]
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: hsw_uncore
        Kernel modules: ie31200_edac

# edac-util -v
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 0 Corrected Errors with no DIMM info
mc0: csrow0: 0 Uncorrected Errors
mc0: csrow0: mc#0csrow#0channel#0: 0 Corrected Errors
mc0: csrow1: 0 Uncorrected Errors
mc0: csrow1: mc#0csrow#1channel#0: 0 Corrected Errors
edac-util: No errors to report.

I don't know if it's truly working because I can't overclock the RAM
to induce ECC errors, but still I think adding 8086:0c00 to this
driver could be useful.
