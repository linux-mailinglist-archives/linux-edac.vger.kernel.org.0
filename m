Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD29245333
	for <lists+linux-edac@lfdr.de>; Sat, 15 Aug 2020 23:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgHOV7P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgHOVvn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Aug 2020 17:51:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2EEC09B046
        for <linux-edac@vger.kernel.org>; Sat, 15 Aug 2020 08:21:33 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so12920220ljc.10
        for <linux-edac@vger.kernel.org>; Sat, 15 Aug 2020 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoYSOcagikdOmgPviZEP2LliGHPAyUYpPZFQ5sfcSPo=;
        b=Uv7csibiolw1CuDlu16Gy1hKMGKzL80fWUarG895vX9a1+KeDE9e1ot+4TvzccwzMR
         7s/XPY7UZdQ9YZUx9LK4npjhhqyLxQNqNQwHgvbJ8JQtshZui0zkyL6ja2vXp8W57rPJ
         Rzfj5yclo7NtNqAedLzGCeYsDz+hP+x+ECSmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoYSOcagikdOmgPviZEP2LliGHPAyUYpPZFQ5sfcSPo=;
        b=ndGAVdfFGMmLUE0pwjWyfx8KeO5Gdsh7UxT84ws+2M/FvJDHscdf46q6du2m8YGrVI
         dxMPoZdT+X73cv4AUbncrNNRLM5NI3A40PEWz9v0MUw7RmJ9CWFOmpUqiTDYXuTtBeyv
         XePswaPSlcEhgtMlS1Gqz8JEL7Q/taIMQsIBSfUAvHf+MePT276zQP8nBDnJlDh6kW6A
         MDZuEWWSfxpBiB9xQpHp3PdeteDeTQJFd4YM3IPix4m0JfD2efeVwerlCh24zShLzKNp
         z0la2nIMU1w68YVn6aAURhDG6J+hSkvsHojj5LztJDS9vc5rYBxu52pGzlG3uNNcy+ml
         fsSw==
X-Gm-Message-State: AOAM533cDlJLcVtrr9X7OyyL624crt4omv259kBok+G11gfiD+/49/f8
        eJEAr8yCMN04E1yaiShoOsggtGEoEDVGBw==
X-Google-Smtp-Source: ABdhPJwDTgw79HWEOObUwmdKzYFKlh1pM+1t1q1IqtYh79+xivTyHBRftOVibke3Ouyh3hwtESxGwA==
X-Received: by 2002:a2e:93cd:: with SMTP id p13mr3719874ljh.460.1597504890795;
        Sat, 15 Aug 2020 08:21:30 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v20sm2471028lji.64.2020.08.15.08.21.29
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 08:21:29 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id w14so12936881ljj.4
        for <linux-edac@vger.kernel.org>; Sat, 15 Aug 2020 08:21:29 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3202606ljk.421.1597504889274;
 Sat, 15 Aug 2020 08:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 15 Aug 2020 08:21:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com>
Message-ID: <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com>
Subject: Re: [GIT PULL] edac for v5.9 (part 2)
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 14, 2020 at 5:36 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Here's one more pull for EDAC with a driver that I let slip
> through the cracks.

Shortlog? Diffstat? Just what am I getting?

                Linus
