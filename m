Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2063251CD6
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHYQDf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHYQDN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Aug 2020 12:03:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEBBC061799
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id g6so1471892pjl.0
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Ev7YebnrMJC5hGp27fNNwdoImL+JDFARELNBma0/uAA=;
        b=okyPVVy74yhlMZQCWF4kzfTd4X55KXDYOqzLJQnAIW0h1IFAYQXbSPLOVAMXMA3C3j
         tL/HLBWDHQzpJj4ci2GUYu5lisDQtceXxLtpRS3C1N6QiXc629q7MzAhIlKzsE/O6Jxp
         hxXjODLVSsA6omJuJUBYBjG3837I0mbscmwd9DDiSmJNrH7kgNiRNwtZuorFkk/LFb9S
         8UetkH/uOhJseG0AECV3EuEvJy1vGwu2TbWICNUOLQB0uPtfvydMA8RjobjPyJ5HGasI
         na6uzBxKd/6d/1odYvw97QotgbrYy+3q+PDbivrnLe7VTnK7Y1ItmndVIMa2H90PXS1/
         vWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Ev7YebnrMJC5hGp27fNNwdoImL+JDFARELNBma0/uAA=;
        b=SBkjT0W109wPzFjxEXFn0ICTjJ6TZJCu0O8BMeQufn7iQMJB6CTxZlvWZrkCTfM0rg
         at4iiRdrCLZk8lnh/vKKQJusTp9C8Yd0zIpHjjZjQUCXM/O9qCeqTsPIZrO7xHYRgSjh
         TITkKXjVajyja1O4iW0XSCVplRDs9tupQI05FWqqP8C7eI1x+Unq7CymE9NkoIkyZtpA
         DKVfS/flMs4wllUSfQ+Kh13UaPvyn5f89piVGsqXMXE1VdVPNf89oxnkL+sulDvi1PJc
         ux+uiindfQYDCGfJaXG5NTQZ5X5xOjv2IS4QhJtgEKeltg2v3tpdT3mObW4sgKi0MQV7
         K8Ww==
X-Gm-Message-State: AOAM531GlhcK/6jqrZxpwzXsdggGH78o1MYIk4AQMb7uVuqR2p8xmI0l
        eYKVOHVIkBGUbJU5zP0KZKdXMg==
X-Google-Smtp-Source: ABdhPJxVMLNNcoGNUamsRb6XNuw5Pw/vE4Xo0oCs/JaO+Bek+U4WRn0q62JXgjoWyYfGNhJmC9XG0Q==
X-Received: by 2002:a17:90a:f994:: with SMTP id cq20mr2218207pjb.229.1598371375255;
        Tue, 25 Aug 2020 09:02:55 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t19sm15483792pfq.179.2020.08.25.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:02:54 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:02:54 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Aug 2020 09:02:48 PDT (-0700)
Subject:     Re: [PATCH 0/3] SiFive DDR controller and EDAC support
In-Reply-To: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-eeb15e05-0af6-42bd-8c35-0b7e9bbedba7@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 25 Aug 2020 05:06:19 PDT (-0700), yash.shah@sifive.com wrote:
> The series add supports for SiFive DDR controller driver. This driver
> is use to manage the Cadence DDR controller present in SiFive SoCs.
> Currently it manages only the EDAC feature of the DDR controller.
> The series also adds Memory controller EDAC support for SiFive platform.
> It register for notifier event from SiFive DDR controller driver.
>
> The series is tested and based on Linux v5.8.
>
> For testing on Hifive Unleashed:
> 1. Enable the ECC bit of DDR controller during DDR initialization
> 2. Erase the entire DRAM in bootloader stage
> 3. Using FWC feature of DDR controller force ecc error to test
>
> Yash Shah (3):
>   dt-bindings: riscv: Add DT documentation for DDR Controller in SiFive
>     SoCs
>   soc: sifive: Add SiFive specific Cadence DDR controller driver
>   edac: sifive: Add EDAC support for Memory Controller in SiFive SoCs
>
>  .../devicetree/bindings/riscv/sifive-ddr.yaml      |  41 ++++
>  drivers/edac/Kconfig                               |   2 +-
>  drivers/edac/sifive_edac.c                         | 117 ++++++++++++
>  drivers/soc/sifive/Kconfig                         |   6 +
>  drivers/soc/sifive/Makefile                        |   3 +-
>  drivers/soc/sifive/sifive_ddr.c                    | 207 +++++++++++++++++++++
>  include/soc/sifive/sifive_ddr.h                    |  73 ++++++++
>  7 files changed, 447 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
>  create mode 100644 drivers/soc/sifive/sifive_ddr.c
>  create mode 100644 include/soc/sifive/sifive_ddr.h

Thanks.  These look good to me and I'm happy to take them through the RISC-V
tree, but I'm going to wait for a bit to see if there are any comments from the
maintainers of the various subsystems before doing so.
