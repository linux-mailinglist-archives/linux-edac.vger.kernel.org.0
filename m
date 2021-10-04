Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BEF421471
	for <lists+linux-edac@lfdr.de>; Mon,  4 Oct 2021 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhJDQzL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Oct 2021 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhJDQzL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Oct 2021 12:55:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA02C061745
        for <linux-edac@vger.kernel.org>; Mon,  4 Oct 2021 09:53:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j15so312990plh.7
        for <linux-edac@vger.kernel.org>; Mon, 04 Oct 2021 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUf5cLarGbiZnEVQ0Jzbit4iKZIxXZvjgSxdN+0foqc=;
        b=Vx5dqKS/inyiI6BZVCDIbx4UiQ0h+MwxKSDQSPjEPPX2/1cd8EQ8qr9Bd+t2Iv9Vtn
         o4D0NdAD3wLu3IcOFiismcNxu+wyOjUhHv2Nq7pEOHKPMny+oFgaMtZ9OIpmcL0Lve85
         d3dnIiNMkk15Bv/lvsO50uuKyZj1h/4lSm6V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUf5cLarGbiZnEVQ0Jzbit4iKZIxXZvjgSxdN+0foqc=;
        b=OX3Wvr6vJU9+shkVmIZEfrXfJvwho5cLg2/8F2RyUpAs5DC4plrDGWEjB1kqz40Hbm
         ht/P+CHPUywqsWswTvPcmrrpVvhb4Yp/crTZcwbahuKXB4kngp1dWdMT8NzLzhMnv0+Q
         fGtdhFtAPO8aun6yJZSt2LOxDmXdFrRjakpVYe9WvadvnUIYFpJLsH2wo734IGVxPmPY
         LbGhe+ToiX5FVbCduVSSx+x5toEN01f59EtbuIgyrvi3qtdoQYgnxhqp9P4PyX9QGYq6
         l1T1bBMEC16eukqj9x1Prf6lbFzjBGGIeoMbwr9sfH08qZqDecsUJjxAvJHYmMEBonMM
         FAUw==
X-Gm-Message-State: AOAM5300anuDE94zZVYIdNqoypqkZ4PLJVw7dO3zTA35GtvnlCZRxIVt
        L7bffiR+1U2LymgzXjZFnqaCKg==
X-Google-Smtp-Source: ABdhPJw6z9JMaEksrrfUCdhF1zMg6OajCMv5wDqRrCT1ktQzZlZPw+WHtJxMGyDW7ekLIIMMypGhFQ==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr31633347pjj.117.1633366401867;
        Mon, 04 Oct 2021 09:53:21 -0700 (PDT)
Received: from ebps (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id z2sm3550319pfe.210.2021.10.04.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:53:21 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:53:18 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Message-ID: <20211004165318.GA700900@ebps>
References: <20211003181653.GA685515@ebadger-ThinkPad-T590>
 <045ce9cf33904a52a365a04c055c5cbf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045ce9cf33904a52a365a04c055c5cbf@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 04, 2021 at 03:21:13PM +0000, Luck, Tony wrote:
> > This is cosmetically nicer for counts > INT32_MAX, and aligns the
> > MC-scope format with that of the lower layer sysfs counter files.
> 
> While this is technically the right thing to do, I pity the system administrator that
> is looking at a system with more than 2147483647 corrected or uncorrected errors!
> 
> So:
> 
> Acked-by: Tony Luck <tony.luck@intel.com>
> 
> but maybe this is just churn and not really useful in practice?

Pity accepted :). I only noticed the sign mismatch after seeing a
negative value on a server in the wild. But it's cosmetic really; if
you've reached INT32_MAX you'll probably reach UINT32_MAX and can't rely
on the counter.

Cheers,
Eric
