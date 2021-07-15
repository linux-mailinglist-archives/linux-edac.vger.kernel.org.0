Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8306A3CAB86
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jul 2021 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhGOTUe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jul 2021 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245112AbhGOTTT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jul 2021 15:19:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BFC025279
        for <linux-edac@vger.kernel.org>; Thu, 15 Jul 2021 12:02:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q16so11722564lfa.5
        for <linux-edac@vger.kernel.org>; Thu, 15 Jul 2021 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+Fsx0+xO2DUQDr/8J4kzsGkweoKC10KufyE4syMsO0=;
        b=R/PTOy1sFpExaG5/lUxJrf1lFemVJMw7lAGWZ++N6p3TuZE7zRaNXpadn8YKGbrlkn
         pDRLDYozSXlglKio+q9qQS13OyoQb6Hp7tPU0gW4iy0JG1FK/X1nNeZ2Vvi3ZmVOTy36
         URW51Ulom9SQ3N1EhpgXDEpPMTfbI1SnOXG54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+Fsx0+xO2DUQDr/8J4kzsGkweoKC10KufyE4syMsO0=;
        b=POaiI8LBXXhOwsBsOurZDctIGyBPCW+VVaHkQVONFdo8uXMrWPMadLOIlRyXJlNi84
         zYlLNjS6Zk8BvIw0kgStV5rvw/jc0jD0VB31US+kN3CZJ5+/o1OpskFbW9+/Z2IhfI4S
         L3gqg/AMDllqrmyRgGRlovIPyvUBWo1WAILcjcFgWsr6P9fiBNh1LTr0xBKJypqumHW2
         t7UX+VDRb77+xS3T4/UdK3pBm98qFGgu89cWSsFnGhMAHcPaJsfCgNu/vRiK3yldFRr0
         7gLLmFj41eT+E6YFI5WuVHpgv4Dt6StktuBJC9b9n1n54ycUW6iL27Sv7WH49PLFyEJL
         333g==
X-Gm-Message-State: AOAM531jMtv4jj43Q3slWyUGPyrR0U/d0jlmvCEvMA2x0398oH87aOkw
        H3bw583Ar/uMxmTdqi0x49vpCurDdrFN9yZ+
X-Google-Smtp-Source: ABdhPJwsd3I8WnFR+F24pFwlmZGqrGx6blAAVLLwExZIeaf/WA1ZywPWDRdh2NeFmv/e/zSh2IQE1Q==
X-Received: by 2002:a19:d609:: with SMTP id n9mr4619561lfg.198.1626375774799;
        Thu, 15 Jul 2021 12:02:54 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h26sm708672ljg.95.2021.07.15.12.02.53
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 12:02:54 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id x19so1624975ljc.4
        for <linux-edac@vger.kernel.org>; Thu, 15 Jul 2021 12:02:53 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr5215367ljg.48.1626375773644;
 Thu, 15 Jul 2021 12:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210715185531.1374900-1-tony.luck@intel.com>
In-Reply-To: <20210715185531.1374900-1-tony.luck@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Jul 2021 12:02:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAAJ1he2MaXuBXCZzQQNd0_jgyJrZLwK1K8mWc_2fXFA@mail.gmail.com>
Message-ID: <CAHk-=wiAAJ1he2MaXuBXCZzQQNd0_jgyJrZLwK1K8mWc_2fXFA@mail.gmail.com>
Subject: Re: [PATCH Linus - please apply] EDAC/igen6: fix core dependency AGAIN
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        bowsingbetee <bowsingbetee@protonmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 15, 2021 at 11:55 AM Tony Luck <tony.luck@intel.com> wrote:
>
> My previous patch had a typo/thinko which prevents this driver
> from being enabled: change X64_64 to X86_64.

Heh. Applied.

              Linus
