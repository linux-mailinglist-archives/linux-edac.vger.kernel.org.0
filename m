Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA87339AF5
	for <lists+linux-edac@lfdr.de>; Sat, 13 Mar 2021 02:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCMBz5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Mar 2021 20:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCMBze (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 Mar 2021 20:55:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E0C061761
        for <linux-edac@vger.kernel.org>; Fri, 12 Mar 2021 17:55:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id dw22so1197954pjb.6
        for <linux-edac@vger.kernel.org>; Fri, 12 Mar 2021 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SmCiaIj4fa/BntGmklruqMNsz/t3oXGt1XKruu0aMRA=;
        b=B98B11Im5itjp0Kmsnv8x0PVZohh9t3Z+Qe0bEFacNwdVrdELuVlSdcNMc6SnG74QE
         xw5Jga0rtYomYVcIlMYdvVRpSwMW4LAsrezoJ1iUibR9i0F/tJdXw4F/ehpZZrA62104
         OSz8CzWA9rF2PkIjws1SrwHDPL6pVixtmKzIdHWuYVODTvLjsHfU9XN/9Zda34G0vab+
         ktO89BYEoD10KSA3DnUzmNQ/9PgKtcIkWIXR3iAw8iCZDzcOBXUD6opd9rGVkdvFv+wX
         gB064quQ9EUR0Cx/kZFEeHEQrlwM7MkC8Izc7zr+yoWeb5sZGFAq20WExNoZCm9LvecH
         kLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SmCiaIj4fa/BntGmklruqMNsz/t3oXGt1XKruu0aMRA=;
        b=fJhU/sNn2NqiEy1Lz0s8gnbyxI/fNx3qVWT0zVFwV14g2Wp38QoTIUHU8psSEHl2Pb
         e5OIhDuvvrcklvSHENlUa8Zna5mIeaxG8lSmaZwL3q3RiOfTAvtFLfsxGXMctopq14Wj
         U5pIrcfF514aGOucBZpdsA4I8AwibFPw4H8mrmWn3nrfQyzDEoyF/I4yK5Sg4yvxDrzk
         IqjDzLAQnijawJdQYc4b76WEgnlNfuI3Wgx+bog5yDbgs1nU1zHQkthTfRiASjGs2Pn+
         SJVrrc+5digHwkYVJEAmNnlUFKkKr/ytw2Zxgnw5PredZeeFLHYznzzC62iIm380dbFF
         55rA==
X-Gm-Message-State: AOAM531nogSC174L2hBM/1SQIGaRR1mC4ixs2a+dxGeslYu04XhEHlbb
        wVosZiChCJCQOQOoXTpdgzbsw1G0
X-Google-Smtp-Source: ABdhPJwhh25oOc/8AJVs7FL5eGzsu8RlANUl9BwX2RMIN7WSJXFoNJtiRI++7NwAsSX0QjlN4YWHtAqg
X-Received: from juew-desktop.sea.corp.google.com ([2620:15c:100:202:91c2:423c:5356:a5c6])
 (user=juew job=sendgmr) by 2002:a05:6a00:15d4:b029:1fb:17bf:abe5 with SMTP id
 o20-20020a056a0015d4b02901fb17bfabe5mr971565pfu.39.1615600533243; Fri, 12 Mar
 2021 17:55:33 -0800 (PST)
Date:   Fri, 12 Mar 2021 17:55:31 -0800
In-Reply-To: <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
Message-Id: <20210313015531.1737679-1-juew@google.com>
Mime-Version: 1.0
References: <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: Re: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
From:   Jue Wang <juew@google.com>
To:     tony.luck@intel.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, david@redhat.com,
        hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        naoya.horiguchi@nec.com, osalvador@suse.de, tglx@linutronix.de,
        x86@kernel.org, yangfeng1@kingsoft.com, yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I believe the mutex type patch has its own value in protecting 
memory_failure from other inherent races, e.g., races around 
split_huge_page where concurrent MCE happens to different 4k pages 
under the same THP.[1] This realistically can happen given the physical
locality clustering effect of memory errors.

Thanks,
-Jue

[1] The split fails due to a page reference taken by other concurrent 
calling into memory_failure on the same THP.

