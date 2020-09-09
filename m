Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3205F2625AE
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 05:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIDMW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Sep 2020 23:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIIDMS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Sep 2020 23:12:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C37C061573
        for <linux-edac@vger.kernel.org>; Tue,  8 Sep 2020 20:12:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so1013130pgd.5
        for <linux-edac@vger.kernel.org>; Tue, 08 Sep 2020 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=68ipujDablGcEJonPET//NBEYZiQNXSeSF+EeohflME=;
        b=TReKjmiIL072PrYgIA4/D2VQXd+J56RQ/DSJXM7PBArTdXh4/GxSAbvdgGzsHJAyn7
         ZzJPgLqDko2UBN0UMQ3m456optZlKtqlwx+HGq60uJYI57g0ev1xOoEGkDujuTfmrTRo
         FiH/R/Czt0dHCsH1fPA2Uzh2Ecn3HY2ieoZ+DwzBrbfkiDk1bLTXUWeOuqtQtPb3I8Hl
         nrCx1lN7nhoqvEuuNM+G9SPLizyqNFZ3Dls+kQWqSvFJQiPVPYXD/2VYDJ5DyPQLz03B
         1AQRz66PFO6KIS+LKsdx//tDLK7+cJRDShEZyTFsprfBX/yQz0MF5rCeCwec0jk3i8oG
         dXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=68ipujDablGcEJonPET//NBEYZiQNXSeSF+EeohflME=;
        b=pRWY/rdyAQmvFb18ASzER53BBV4O4YBKAoYqnG5kokI+lW8Ir4lPKAeMwGNzbKDq4d
         mQfTgXThOQqKJZkeNqMveo0H8txEEdpp6J/xiYgJYxN/jWphFhM1KWp7TtNC3LfFhZuS
         Wl69WYNaasgyxAHmQiVvTrrRd/fj6VL2hHyxY6CstJqhI56ouCQukyj8YVbE38JVSF60
         4Wx9VKKBYEvjA/LPyVOa2yerr8P7au3pCdF2p0w1oUJPxb5mY3Uo/1z8n5fMmQdSlkV5
         y0c2NkjedqnkH/imIicyaIom2EkD2ZfYfZKhbe+VkbRuFze+llQ/dtfFsKtLmwkEP27/
         7gnw==
X-Gm-Message-State: AOAM530U4XtSeQSJB7iLt1+VdL/2IOLvKgGR28Rs5gch/0EFa74zqcUs
        4ZhcBWdT/kcFcGRlMAxvo9UKwg==
X-Google-Smtp-Source: ABdhPJwexB0r5HrP0KwYZnG4eojTsfNQqFJlDv8+/BCwJd3a9eEytgZ8MppW46t1gK2A2ChRvfFYPw==
X-Received: by 2002:a63:5b64:: with SMTP id l36mr1371109pgm.413.1599621136651;
        Tue, 08 Sep 2020 20:12:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b20sm809072pfb.198.2020.09.08.20.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 20:12:16 -0700 (PDT)
Date:   Tue, 08 Sep 2020 20:12:16 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 20:12:09 PDT (-0700)
Subject:     Re: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR controller driver
In-Reply-To: <20200907061126.GA14999@infradead.org>
CC:     yash.shah@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        rrichter@marvell.com, james.morse@arm.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>, dkangude@cadence.com
Message-ID: <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, 06 Sep 2020 23:11:26 PDT (-0700), Christoph Hellwig wrote:
> On Mon, Sep 07, 2020 at 11:17:58AM +0530, Yash Shah wrote:
>> Add a driver to manage the Cadence DDR controller present on SiFive SoCs
>> At present the driver manages the EDAC feature of the DDR controller.
>> Additional features may be added to the driver in future to control
>> other aspects of the DDR controller.
>
> So if this is a generic(ish) Cadence IP block shouldn't it be named
> Cadence and made generic?  Or is the frontend somehow SiFive specific?

For some reason I thought we had a SiFive-specific interface to this, but I may
have gotten that confused with something else as it's been a while.  Someone
from SiFive would probably have a better idea, but it looks like the person I'd
ask isn't thereany more so I'm all out of options ;)

It looks like there was a very similar driver posted by Dhananjay Kangude from
Cadence in April: https://lkml.org/lkml/2020/4/6/358 .  Some of the register
definitions seem to be different, but the code I looked at is very similar so
there's at least some bits that could be shared.  I found a v4 of that patch
set, but that was back in May: https://lkml.org/lkml/2020/5/11/912 .  It
alludes to a v5, but I can't find one.  I've added Dhananjay, maybe he knows
what's up?

I don't know enough about the block to know if the subtle difference in
register names/offsets means.  They look properly jumbled up (ie, not just an
offset), so maybe there's just different versions or that's the SiFive-specific
part I had bouncing around my head?  Either way, it seems like one driver with
some simple configuration could handle both of these -- either sticking the
offsets in the DT (if they're going to be different everywhere) or by coming up
with some version sort of thing (if there's a handful of these).

I'm now also a bit worried about the provenace of this code.  The two drivers
are errily similar -- for example, the variable definitions in handle_ce()

       u64 err_c_addr = 0x0;
       u64 err_c_data = 0x0;
       u32 err_c_synd, err_c_id;
       u32 sig_val_l, sig_val_h;

are exactly the same.
