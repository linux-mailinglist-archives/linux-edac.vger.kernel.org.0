Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B652F3BBE0
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2019 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfFJShO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jun 2019 14:37:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35824 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfFJShO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Jun 2019 14:37:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id y6so7002932oix.2
        for <linux-edac@vger.kernel.org>; Mon, 10 Jun 2019 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7veQMV4vdO1C5dpO9ycXFC4aPPPHJeIK2IgV104ibaI=;
        b=NUJmW7gmjIxIkooBQg4y/lDJ/e+wTIRZDTLBEabe4PL5dk2JUbI9pxJ77RNDt0oS4F
         uVC2lHr2p9RTXSoqZsnSuSRpxVAw0KnpAp9tsFyspUdAEtHIrnFoSFJexy+M8HJI6Wgi
         +vFO6t1EA+ecbIpBLBF3VKovIUoGihu5958X1xSd1p3knme9cuBehSzzDnWm74WoOTvy
         XutgQjcK/+rs8gxpWgCy6Y7qLBzUniUfeUc5WIBUYRN+J2KkMxvI/kjIzqFFEAUA6yaM
         nG4INVBwmEJ0Z6AY5sDJS8O3KCH371khF+2mi0v7ga3iOt32D/NujwxmoPqtnJGlaf8i
         KGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7veQMV4vdO1C5dpO9ycXFC4aPPPHJeIK2IgV104ibaI=;
        b=MiDhVJqO0B3D52F3yZfrCJZczd29sgF834j2Y+eatDUyoe4YWdvOgJOmQQseh020n5
         XWSud1fB31us/8j+dssxoL1pA8TKqf81uHb8reFrxUK1MuKv4zJ3d2X6H5qovctO7AGs
         JPEn3WHAuRN5VdexgIlsGq2Y7gKGP5mS4FLHR1OFv3JAnZF2OKe0e57fY8tSJPL6FPdr
         rojdps9/e00hpVXaWQ4/ynvp3EQzA7dVvO9DHNnO3xAQ0a52jY9XnUbnJl9QELgvoh3L
         RYpnkrcCiahRvBxz+jVvALmOF6S7e60riOvYV2U+68BrJv25MMn87LNyJQ0XdlxgC5jK
         5pTQ==
X-Gm-Message-State: APjAAAVzuHUYHhbAjWoZxPXl9P8Ivsej+XypAqNWfkd39ZZPQwPxM4Wv
        xaV/UWqL3f1h1TuolXvCT/VkGvyBTcvxbtSSdMobUg==
X-Google-Smtp-Source: APXvYqxa6f9/poTt7ElU5olgALujPLljhaAX0gJHb0JyzDQ5wmo8KA4TkoN0Tjb35MWoMW/J8LDzVE5lm/qeP9F48Ag=
X-Received: by 2002:aca:50d2:: with SMTP id e201mr13187675oib.83.1560191832970;
 Mon, 10 Jun 2019 11:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190609151613.195164-1-elver@google.com> <20190610180121.GA22428@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20190610180121.GA22428@agluck-desk2.amr.corp.intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Jun 2019 20:37:01 +0200
Message-ID: <CANpmjNOVjcgprWviex0uPCCAC4+qW=sh6d+BdYtZATNd-w_hbA@mail.gmail.com>
Subject: Re: [PATCH] EDAC, ie31200: Add Intel Coffee Lake CPU support
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     jbaron@akamai.com, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 10 Jun 2019 at 20:01, Luck, Tony <tony.luck@intel.com> wrote:
>
> On Sun, Jun 09, 2019 at 05:16:13PM +0200, Marco Elver wrote:
>
> Marco,
>
> Thanks for the patch. One comment below.
>
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > -     {
> > -             PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -             IE31200},
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
> > +     { PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +       IE31200 },
>
> Are these lines just changing the formatting from three lines
> per entry to two?

Yes. Originally I had a version that added the new entries in the same
style as before, but failed check_patch.pl due to exceeding 80 chars.
I'll send v2 that reverts the formatting, but has to break line after
the 2nd PCI_ANY_ID for the new entries. I'd prefer not to introduce
another macro.

Thanks,
-- Marco
