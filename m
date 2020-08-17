Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C074247217
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgHQSiP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbgHQP6j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Aug 2020 11:58:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE08C061342
        for <linux-edac@vger.kernel.org>; Mon, 17 Aug 2020 08:58:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so18361548ejc.2
        for <linux-edac@vger.kernel.org>; Mon, 17 Aug 2020 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDW9UCeKCT82tfxaSNxr50xbb9G40cITAcAS3tvi8v0=;
        b=fIPhHRoaOSDBb+ug606oRYS2+MH5nZe6EMkjdBne3K6gkNMRHGFl+IinNJuPE7HtDB
         0P5yIMQN0vJ+D7KsSmoTREIxQXfgHlgP8SLVIrk3NC4rU/MaKeLXMJGlTIJcN3K0LVcb
         8YQq4mPE/eHtEhAhLC0BW/HVfeotG0CFsfiPwcULNgc49IIp3BUAWu/j9DmJsEbY5Vix
         dSa/ahzIk6ZB1COkndigQ1FITezBhbrovkBjR4XKdS84FUjDweagcSiz/Xw4WHOrYy3K
         3hFGJOt8E4buK1kawUekKbFn9He3DVzGb0mVXYxUGMewA1jIhHXUBA22Uf/Fa9IvReEj
         ORPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDW9UCeKCT82tfxaSNxr50xbb9G40cITAcAS3tvi8v0=;
        b=YH6HkcUmFmlRv1RedptiFs8Cc/iKkyOMbdCXapc1KNua6hCR9vEjpz+wASJIdGeSor
         ssjv0ElG/qjIyExZO1rSd5BLIC3UlyqBBVTOHo4TgkuFKiALN2oL8uJ70FEd1YWP+01I
         nAmyxSq5BgByC6KjM5L8RX4sYNnIujkt22hUkciAq1JtMsGwxCMJcsePYqxDrzWYkhyW
         9PStwguxwVrkJ4JlZOEwEwoWrGRbpVB7WvjwggVbnCC+Dc3A2i3LkErG6yngOMs9KL6t
         0tZDRQW6IXUFOFCXWDGm1IUDW+dgemFoS1YIhSQVgQwW8fMgQHCORIu/2iVsxshGk4aQ
         9y6w==
X-Gm-Message-State: AOAM530mYfbZwXtXfVFWFEHtKN/1kun2ylUbWNK8vjfPTGQGYBzRUULv
        ruZhg5mEpinaaiYwVBTCvDViODCtkuMc+J+J1+1Jdg==
X-Google-Smtp-Source: ABdhPJxYeqZjXIthrlvMdVffSVE1rokkXKmYeaKq142LtxPwYHooYBJSF/6fA/EUW56GiEN2+N3Z1Iot+nCiSbSHmCs=
X-Received: by 2002:a17:906:7f05:: with SMTP id d5mr15464122ejr.122.1597679917222;
 Mon, 17 Aug 2020 08:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200805045955.GB9127@nazgul.tnic> <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
 <20200812210909.GA3283093@google.com> <20200817151357.GK549@zn.tnic>
In-Reply-To: <20200817151357.GK549@zn.tnic>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 17 Aug 2020 08:58:26 -0700
Message-ID: <CABCJKuccY-wOEuQm--TQYgJvErOXu5u-jBMgCrM7JYsNqYK=gg@mail.gmail.com>
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
To:     Borislav Petkov <bp@alien8.de>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 17, 2020 at 8:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 12, 2020 at 02:09:09PM -0700, Sami Tolvanen wrote:
> > The type mismatch broke allyesconfig in my test tree and your patch
> > fixes the issue.
>
> How are you building your allyesconfigs? Because allyesconfig works here
> fine on latest Linus tree.

Sorry for not clarifying. This was in a tree with patches for enabling
Clang's Control-Flow Integrity. However, this type mismatch looks like
something that should be fixed regardless.

Sami
