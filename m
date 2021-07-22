Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48F03D24E8
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jul 2021 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhGVNOQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhGVNOP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jul 2021 09:14:15 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7ACC061575
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 06:54:49 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id o4so2102713uae.13
        for <linux-edac@vger.kernel.org>; Thu, 22 Jul 2021 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XFcLEzylnNkqNvuqnNb4WHh+ght78BMzZ5jaCLVXsZQ=;
        b=oB7VFHKAYF2u10xgMegELJG0FkTwPoek8rERNyl5GOibo0ORUXPQOJgZqkvDjyfMpV
         S5IJ0dTh2emkAScz6nIwMDjbqscYflVMFlfdumYmqB9hUIy4R4rXFXRRGNVQ6Ct9y35L
         ntZY0kwseDgFbWt8CwD/50YAK7HBIzNjfR4Z8A+ZSmcUhrkZSzg/Ci1ByTADOlk+pdkH
         VpXncR0JUypyvMD/v162L45DY7zyb1qKIuds/81empaM5XosyAZVHuL1EhXx6SJPFAWj
         trh1GfZVWZatzJKEUdgTh1m8AcXdDRsNd4yUtvU09EhZ/DLMr0KP8MJufC2n0RBdnj3t
         ZXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XFcLEzylnNkqNvuqnNb4WHh+ght78BMzZ5jaCLVXsZQ=;
        b=HqQSH2oGbpvlHm2vzu/8DMfxny4a8qu6mJNtbc0BD4M5IM/veTLpe669d4SrnUaid8
         FeE8Lm2Oe9TpL3/XI5g6Og6Foq8b4Ief4HaVZeTXbKmTIwCvdHovuyCfTNK5W6aTak5z
         R1powQSc8bD1hRoMEwXU21Dloby1r0fhnGv2fy4hojy9fEJXYDtgbcSqdx+GEXPByj/8
         gt5AIi3W/0mSbMnDNuNgIFEL2z0Yn81DQxvy/rS3YHbNaNpZpN4GmFhUeGqrru2buHwn
         EV8zz+0OdNwpiqdSoao/byHiAazTJB2qA2UytLgsJB+gFApZa4IbTvxJkrzPE64TARbp
         H6NQ==
X-Gm-Message-State: AOAM530az3sO0Ki2b8EFK1jSGE0u6U5WXQDheSUSVJPxGK0hDHW2QlHZ
        7CWVU5BgOnxMpJoUdbjQe+/UG8Vbfx4VkQbwbNWFnA==
X-Google-Smtp-Source: ABdhPJx2kKrPaqF4ynhjM+DpwLiZYn2xsWv5ebeRaOTF6JFvfB65g8noTp7P7ZkRSrBcx47xAayMjpY+VGuLwdx/ono=
X-Received: by 2002:ab0:45cc:: with SMTP id u70mr41536169uau.85.1626962088661;
 Thu, 22 Jul 2021 06:54:48 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Thu, 22 Jul 2021 06:54:37 -0700
Message-ID: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch assumes the UC error consumed in kernel is always the same UC.

Yet it's possible two UCs on different pages are consumed in a row.
The patch below will panic on the 2nd MCE. How can we make the code works
on multiple UC errors?


> + int count = ++current->mce_count;
> +
> + /* First call, save all the details */
> + if (count == 1) {
> + current->mce_addr = m->addr;
> + current->mce_kflags = m->kflags;
> + current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> + current->mce_whole_page = whole_page(m);
> + current->mce_kill_me.func = func;
> + }
> ......
> + /* Second or later call, make sure page address matches the one from first call */
> + if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> + mce_panic("Machine checks to different user pages", m, msg);
