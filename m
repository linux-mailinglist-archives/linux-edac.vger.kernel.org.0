Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DD2478A
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2019 07:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfEUFbj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 May 2019 01:31:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44883 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfEUFbi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 May 2019 01:31:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id n134so11987097lfn.11
        for <linux-edac@vger.kernel.org>; Mon, 20 May 2019 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtJH/XFatQoBOkqt6CnXFYn8cVFYIMDvg7sFFa+676w=;
        b=kyLq6vqxe11UGM5dCp65/VIEmlD+ACNL83MCfoFC4CUz1LW2/BkZq4jQPkPHtoH8Ze
         tbExs1uaTjddyOv7pHBFTilzgdvXBRGSZKZXcpcn8xDRUGBmna44cQXLRF96xO5UXA4u
         eYGAysbsIfGMw15tyeUOW4868nK5HtjkxNHYDXZkLaE0/bvwzSKsmyMn1g8Y97f7epr5
         QPgL7TJOZ7IO8L2Aff3vxpQwf56lh+FleBOwoZLtOZ0xtS8nWiBooOlgBkDp+5b0SYgW
         JtV2bfR2aAL4pJj7ygZJl1GuzifomEgI2FgLpQehqn/Cpw+fhIjwKraPQ3DYgPxGcaM3
         8xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtJH/XFatQoBOkqt6CnXFYn8cVFYIMDvg7sFFa+676w=;
        b=BozOkRve6V8z1puzdGgnv21Gq43a2L8EVrfqLg70dSMEhkHyQPgnhfs0V7NMI9veS6
         z/du6pAjwVIxJchxc6kM4F8S9txGgMzTOH2OuLzkspPJsjT2I/0hryqNEuVwIVs9HjCN
         4EFH/fcRNGmLApvO0/IZ8jVYj9b81h8HkuVJNGAHYYW3+VvMFDTjK7SNGry0HH0qcC+r
         Hc5KX7gK0S9Uex80obFVQ7V3sa0kMNCpa8DUrTLz6Z9/qU/7njNcMcOFSdGf7VrCRQ7h
         laeA3poSxikNV1m9UeJkrbTJ1aoA60aNZUasuE3s9mZ9MvhtQX+LpG3C6P3XFA57JGFU
         ChPg==
X-Gm-Message-State: APjAAAVyIJ/PEJi0hHeGoEl0Cn44+2t2yGxcb6o16V0L2koy+VBpZuBe
        yfXrbkxVngjq9XUx1C3rOe/olgKN7RfvT6aK8l99Snh+
X-Google-Smtp-Source: APXvYqwTO5cDb3MVcX3rsZTp5AzbDa+LWhvMDys5bBDQIRDcxlANQjUTioD3NEoxscJG3c+mMbm/QAYAZESzHIp/t1k=
X-Received: by 2002:a19:c60f:: with SMTP id w15mr39497034lff.61.1558416695999;
 Mon, 20 May 2019 22:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com> <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 21 May 2019 11:00:59 +0530
Message-ID: <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com>
Subject: Re: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
To:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 6, 2019 at 4:57 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> The initial ver of EDAC driver supports:
> - ECC event monitoring and reporting through the EDAC framework for SiFive
>   L2 cache controller.
>
> The EDAC driver registers for notifier events from the L2 cache controller
> driver (arch/riscv/mm/sifive_l2_cache.c) for L2 ECC events
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
> This patch depends on patch
> 'RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs'
> https://lkml.org/lkml/2019/5/6/255

The prerequisite patch (sifive_l2_cache driver) has been merged into
mainline v5.2-rc1
It should be OK to merge this edac driver now.

- Yash
