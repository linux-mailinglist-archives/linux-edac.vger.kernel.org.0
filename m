Return-Path: <linux-edac+bounces-5349-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECBC36E49
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3B5B348FDB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6DF34F473;
	Wed,  5 Nov 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H45R/jf8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB0340A7A
	for <linux-edac@vger.kernel.org>; Wed,  5 Nov 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361764; cv=none; b=bU6KrFZIw35XiVafttxF7LnIDrth6TGGMve+xb0MKPNfxxABRjN6O1wB2TdYUIfrMJZwnHGMryoY1KWAT3ZQN1V5R+tCL4rMsXluZV6scyMj39JEMZi+3K78Lvyq1CG+zmkj2BHkxTHOXg3WjvCYY4kODYruTqQeydKwSfB4rKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361764; c=relaxed/simple;
	bh=kVWi8GxnKucgFki130G61MrbSViUM5WNdG0BJHHZ1qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IArCaqh4GA33IA1WLy1elWKUJXFn6kyR06f+BZaN4T6DGcjoOzhF5DOLpIGd4WBeEKIm/UTafJHRW86NMe+NHgeZ5HouS6kV/1SqpDG7XbdslQKlgTF0bO9rwZjJtMbutyDOtkg5sSB5CNOaKIfAyyqxTkk5jPQq+xMc/bjP7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H45R/jf8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-591c9934e0cso43497e87.0
        for <linux-edac@vger.kernel.org>; Wed, 05 Nov 2025 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762361760; x=1762966560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu3iCcRyO4MEYUoGPnPQxRoQuwG564a8TEJNky+SL5E=;
        b=H45R/jf8Vcf1faTQvglEW8cOHmPugT33sryAzlfGv2Pt805RaXVaVmX+luY/7JXvbC
         pW9n+wxdcsNO7Rt0QV8NUl2A70BvBPO1CAHTWSiwtR3qdm2Kq4OaMmrh0wFDhSFvhzvK
         J2yisg3aXQYGZchKXwWfVhjFRbHFwCkR4nKxMXFD6eaoLKlbmS0u9psEMz/DO4ZWHBsp
         tqT+TYdGJXTiyDnaaQcyA5LYI6QEQqc7iCfgyP8C+N6KnzFfx/l5lIzkEcjidfWqm5Ee
         1usJQpR8HYNuE2c4RGLeuQvX707SY7qLEn4/8V6RJ8rJc60vagRlNi8MhARPYxPY+xdT
         hVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361760; x=1762966560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mu3iCcRyO4MEYUoGPnPQxRoQuwG564a8TEJNky+SL5E=;
        b=tT6GdXDl63I2Z9hwGI4rPUNwnX3xEB7PifLfqo7X3xzS7zI8oSV2GfxtC0z6y1qT3r
         8czD7+HOKsdvGTxgmIdQmAeYClSE3Hj0QbfjL99RXP6MGWnBOwK259xry1+sRwZWRddi
         S9Es6CJxESkqbYV6NiqNKZfVu86BTdMEEQv6xtVILjz271nwlRacpRWPpLt+BbSO/lGL
         4El6/p9mEZiA7w/hx1zLencdT3DH1GAwogfPZylNw8HZIw2Hpwnf6BpC9mJP9bv/ia21
         RGM9MmgUDRIo2BuU/gUUX62xNPxI0+ryT1HElUUlKZAi/eYsHNUkTfIuT6WY8AoaKo8F
         UwyA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ejiY+HO0dpvcjQemcXn/VoyoGykb4Bnye34ecH50fPT4ptJJ76+aTo1Fn8zOMxSWZBF5sSZqVUO3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+Qqj2dFXRerHcTPoiJ6Lmx9wYii1mrh8W3v7fpH3K835+I0k
	czVczOUAXQObBYgVgQ/zhoyeKVjHP9w3NDVvvhIfBvyonGuGqv2cCwL4dHvn6zpClrbYZBd7AOl
	X4dyqpQZ5xesVd0+vOXoSj5NipbT6gpcOQ0lvzBWdRw==
X-Gm-Gg: ASbGncvExbQERxgGoq89nYeGj7tKOtDjqIWRIFdpIffHaVByLIgk26NSP4i6ShcnIj1
	aLDXC1q+pv1rls7Fz1gbgFCWlyaQJMIDYzcrwbWfnrEBOnO7enSRMCkmkvxuq9m3dRmCA5kgdtK
	LgeFZbu6NqFEBixWPoVSh4cayXObar3nqc/G0GJJa9j8UmuWcnxZ5gDfPPrIEkeQFl6mCVDTCyZ
	wkTCB6rPEeL177WhLAA+45gmAfP3X1HtcnmlieEtLNbL1kaMFM02Cg5IR9rInTkNk2wWuZ4jpzE
	hrtTqllxhBcJm5U6Z4XGz8v1y479
X-Google-Smtp-Source: AGHT+IFz+1Gy6h+Xew8BuT3iEzfYRkMwKM5RzviXIBrULzVANbhzC4SaeUAAuRf0icL5+lbsY/ZapaIFTCdyX5G6B/0=
X-Received: by 2002:ac2:4c49:0:b0:592:f7cf:9f6f with SMTP id
 2adb3069b0e04-5943d5642camr1272844e87.14.1762361760364; Wed, 05 Nov 2025
 08:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com> <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
In-Reply-To: <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 5 Nov 2025 17:55:49 +0100
X-Gm-Features: AWmQ_bniiZGELB4ofmitO9AqJwgDRZXbsfcGSPurKdMDAfg0lzfQJrcg_6W0nRE
Message-ID: <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Many thanks for all the information. I've already changed the commit
log for the v2.

> > with the change introducing new workqueues and a new alloc_workqueue flag:
> >
> > commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> > commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> >
> > Replace system_wq with system_percpu_wq, keeping the old behavior.
>
> What is the new behavior?
>
> Should this driver be converted to it?

The code is using system_wq, this is the per-cpu workqueue. This
change will only
replace system_wq with system_percpu_wq. So the behavior is the same as before.

Thanks!

-- 

Marco Crivellari

L3 Support Engineer, Technology & Product

