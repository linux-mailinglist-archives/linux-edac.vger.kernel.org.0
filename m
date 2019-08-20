Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9389570F
	for <lists+linux-edac@lfdr.de>; Tue, 20 Aug 2019 08:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfHTGDq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Aug 2019 02:03:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42665 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTGDq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 20 Aug 2019 02:03:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so3938785ljj.9
        for <linux-edac@vger.kernel.org>; Mon, 19 Aug 2019 23:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEususRD/p1RLs1UC0IHIQOxqNXf3vrCgl3jM8yPylM=;
        b=ZxUq3Kp89/RuJJxAjlEVsnBbqb9KmnuT0R5zHGHBdbrxaNlezCCVDq411Tluue2X3v
         CDV6Ry8uDcWi13dhGFs7qsDEhlLxNNzLxjmtdJWBzT3P4CHbdCRazpwfAOBgotYmutMp
         xwT4O23Hh5DQAh5thGp7AW11u2iB2gD50z1FKawJ1U2Eqr31jQzvlnC4rXrJtvSybPGT
         ovUThUB48Tx5llHOHCvvg4c8ZwTUWrYJqLrzY5lKFawC+QJYoHEt2h5okvRt4Vuz3Llx
         gr9bpAj06ZBXeU96INjnwPzds33RNXp1tjUkx9TRFcASyo67IySLzVipyeXyA8XA+n8o
         vW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEususRD/p1RLs1UC0IHIQOxqNXf3vrCgl3jM8yPylM=;
        b=WHITxFLBWmpBVauA+Bu1scQeIEMnh0bPO+nsJP1BYK9+JVpcYxeYwEH2H8iFvq7dj3
         dWmugNOFysF7TKKottdFkiHJsAJcSxUEj72ZafYRcUEpYZ6+ItreN3cZJ1/QgqiWA+Nj
         g0noCYDomxwmmSB0lYoamnRroR0/gYNsWtth52XUMOcOHxeJpfZgyyP0/QEhMiLI4uY4
         VEk0FF73CS1l3z5yEPcwPHCTQoCa2It8aos4cb4aN55VPHpvpsz7odyOxN26dTOJnK4U
         FvIfOLJuWCDDLE7WLJpKRqJ9sdX60VTWgrKs5zb5CUlFbkcIeomk3Mtt1UJXfNd+loDF
         fo9w==
X-Gm-Message-State: APjAAAUMhLzIJEU5RiNJtfyluzjoxcD+rSvR9h0jCB8iLK+y2UoMzjOU
        gCLceZaKNPaTKEirjLNhdtimmvo/mMD5ex9zLqkT1ivm
X-Google-Smtp-Source: APXvYqz1GXfTgzlkZFJTZ7cQNct2UId8Tmq9X/mNPWaQHmPrJUI6MVbVOZbWegp1Us89EVl8iOBnaJ2+PEhtxHG/Tg4=
X-Received: by 2002:a2e:9f0f:: with SMTP id u15mr14579422ljk.54.1566281024086;
 Mon, 19 Aug 2019 23:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic>
 <20190819062619.GA20211@lst.de>
In-Reply-To: <20190819062619.GA20211@lst.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 20 Aug 2019 11:33:07 +0530
Message-ID: <CAJ2_jOE+JX201biExFRziPTuw3tYFJwsrc5h-Uvg+=fcaobTww@mail.gmail.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 19, 2019 at 11:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 19, 2019 at 08:09:04AM +0200, Borislav Petkov wrote:
> > On Sun, Aug 18, 2019 at 10:29:35AM +0200, Christoph Hellwig wrote:
> > > The sifive_l2_cache.c is in no way related to RISC-V architecture
> > > memory management.  It is a little stub driver working around the fact
> > > that the EDAC maintainers prefer their drivers to be structured in a
> > > certain way
> >
> > That changed recently so I guess we can do the per-IP block driver after
> > all, if people would still prefer it.
>
> That would seem like the best idea.  But I don't really know this code
> well enough myself, and I really need to get this code out of the
> forced on RISC-V codebase as some SOCs I'm working with simply don't
> have the memory for it..
>
> So unless someone signs up to do a per-IP block edac drivers instead
> very quickly I'd still like to see something like this go into 5.4
> for now.

As of now, we can pull this patch into 5.4. Later, I will review if
per-IP block edac driver is needed and if so, will take care of
implementing it.

- Yash
