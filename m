Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6076E2F227D
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 23:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbhAKWMk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 17:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAKWMj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Jan 2021 17:12:39 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132FC061786
        for <linux-edac@vger.kernel.org>; Mon, 11 Jan 2021 14:11:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 15so73676pgx.7
        for <linux-edac@vger.kernel.org>; Mon, 11 Jan 2021 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HS7fxdK8JZoFgzbZviQDL+FJot9ytoncxDHn7G7o7hU=;
        b=N7A7iQCrzatkQ5cCobcCikH4tHwyq62MMxZUpCjV0P2VTkTTTjtghzY3FYBg44GCVg
         l0anrYZpCE+ugJIxWSO62h22DQ4/WmYRZgr8P7oIm3edhizY3pjzCWsYjjlzLgbB5ZY6
         +sRv2zNCr/xUPttFKn9FEVK/92e+dS7VeiuQTArgIbfC240td3LsfyrItnd0EuVfNz64
         PHLGtWX9MxVFMGt43Gp0P5oHN3rMNp/IhCSt0KKqBLwAYEUYgGesBNPAFCH8R6ae/lpo
         XElKavbwO8xbtGial7DbFuGaanxBo+99apBaNcptQuY/Hkpi8IK8UzBxcSAOiWvdcTv7
         4C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HS7fxdK8JZoFgzbZviQDL+FJot9ytoncxDHn7G7o7hU=;
        b=VBTu4vUr1q+7ZHQu0e7WXBeoXxNpVbEnVQpl1GcMoPu6kCS8it2fhRoIr3eqyW5gDH
         4+lTltNR5zETICQOGTLVm6bL55KCDOdyzCCR+KvrkrxZ1wW6L9iffJVYgpVw7monoQ/C
         J+3ZHDk59ZzWjhzWjwbTCdYdG8YBPLh2MhoL2WXOqDcUieSLi+lnSW1dMP5bWb2yP9KK
         Zm0kiXLHwFWl054Q7AYqrYSE+fV/55hb8d6f/28lLN4HOVN0PfrEhBBLq+rKjLpTbsAf
         IDyPIrw0GpQg9iXXTddykgxocZRhtkleMtoylLymEZrkR7Wg8eqzkCze7WyeQq24+wOd
         XYtA==
X-Gm-Message-State: AOAM533s73S44VPiJ0DY7RZtTNnTdB7Qk5Zjkimsq4lJ2V4t1uHSpMxC
        aw1Q235l3MfPnPWxBR/3m0nn5Q==
X-Google-Smtp-Source: ABdhPJwtazOAjIUNjsp7P6XBjKEky8Y/ydC2ogSCffAC48MQyc7KChGD2v03jQV/bFeIMs7ikFsouA==
X-Received: by 2002:a63:3e8f:: with SMTP id l137mr1519125pga.117.1610403118800;
        Mon, 11 Jan 2021 14:11:58 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:4d0d:5741:f5e3:172? ([2601:646:c200:1ef2:4d0d:5741:f5e3:172])
        by smtp.gmail.com with ESMTPSA id z23sm658756pfj.143.2021.01.11.14.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 14:11:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
Date:   Mon, 11 Jan 2021 14:11:56 -0800
Message-Id: <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
References: <20210111214452.1826-2-tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20210111214452.1826-2-tony.luck@intel.com>
To:     Tony Luck <tony.luck@intel.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> On Jan 11, 2021, at 1:45 PM, Tony Luck <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BFRecovery action when get_user() triggers a machine check uses the=
 fixup
> path to make get_user() return -EFAULT.  Also queue_task_work() sets up
> so that kill_me_maybe() will be called on return to user mode to send a
> SIGBUS to the current process.
>=20
> But there are places in the kernel where the code assumes that this
> EFAULT return was simply because of a page fault. The code takes some
> action to fix that, and then retries the access. This results in a second
> machine check.
>=20
> While processing this second machine check queue_task_work() is called
> again. But since this uses the same callback_head structure that
> was used in the first call, the net result is an entry on the
> current->task_works list that points to itself.

Is this happening in pagefault_disable context or normal sleepable fault con=
text?  If the latter, maybe we should reconsider finding a way for the machi=
ne check code to do its work inline instead of deferring it.

Yes, I realize this is messy, but maybe it=E2=80=99s not that messy. Concept=
ually, we just (famous last words) need to arrange for an MCE with IF=3D1 to=
 switch off the IST stack and run like a normal exception.=
