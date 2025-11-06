Return-Path: <linux-edac+bounces-5357-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76740C39C77
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 10:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2084E3DD3
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BEF2D63E2;
	Thu,  6 Nov 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OVGAPDYU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4236269AE9
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420653; cv=none; b=UjKu0MnfD6Oa+Pp6IN3h3vLIW+dsgRcg77A+kUPl+NKBz6mrZEKr6RJqFtaFAb5Yh2CEca/yhCr8isysouob4pRDly7kE4hP4JyYxUPhcdFReIO90gdfjA1M+EMptn4LDYVaYhE2rH0791Gnv+GOdJmTe7eGU8/s6QqsETP2DcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420653; c=relaxed/simple;
	bh=h+z+1A5u4C64dFdqyznJ2FIRrcH9CONAjEw5abNXjfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3Er4Lt7vuGKssxtwvCiKVfdfYnhl6oAe33EJOChuu1a0K1HuwcSVarCCWdPcPszPGCwywODtMScAPQc5kVMDUCTCUKDD1fQWMfGazhZB+HF0Pagg/WHqGbQ3y9PhEu3C9Cz7WOWq63zTgJmo29tabucz/PvOyy8/xTzPMRxb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OVGAPDYU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592f7e50da2so922345e87.0
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762420650; x=1763025450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+z+1A5u4C64dFdqyznJ2FIRrcH9CONAjEw5abNXjfY=;
        b=OVGAPDYUxzGBXPtiUePPQX77Skiu8GJoWzZSf06Tn8MXxvNRAjzRY5aydVUdfEdBF2
         8YRYep9Hi41vVS3Ys4epuw+Er6vsU3/aDFugHnKLeb0avU6yvcYoRy27ehe6H5BVOlE7
         GBz2TPtZ01pZrfRe9MHxrTsVPTQN2NWEQgg+NSDQSgdjFEVz0qgSepI9xEZTqYsCCHWF
         V3zuoyHDarF7vxkxUbF6EKpmKW/KUQBD232sPuUwkPjeYesCiOy9QhgBFRJXjt3pYlVH
         D3eUxiUfgIfQi6oEWImQJBXJ702YJT2v971wSX6yPRUKMRFSMtLnK6ljUzVaDiBHDdO9
         viLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420650; x=1763025450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+z+1A5u4C64dFdqyznJ2FIRrcH9CONAjEw5abNXjfY=;
        b=mL6Aa6vFHx1R3UVQaC/IATZ8PLFGudTElrPKKR1PabCWsenLWCXObQs/1lXS0aupg9
         trlfH3oLIdelivwgE+V/DkPlKmy7sYrXn0BtcLeuiqzupg7vLsFz4lOPmEnYyGTbKMOt
         QDgatlo26rNxW7lrJNQDZE7vH/OA+l+IqQDcAGTDePTDMN1PCwVel0fR/gtOQxURS87c
         7rYT4EPTtbeowuIyc0lDEP1lkmlXshZu6i+ivBOMjkCbmff/X2+N5AXnAD8+xFwpSVOU
         1fWp41VzjvN0ejwfBb44KWAVNKeYt8fgtET0UhIBlGIp48XlCtpAE+gjODM3TtIUIzKz
         eBvw==
X-Forwarded-Encrypted: i=1; AJvYcCX5EiRxE2v1CsUpIXcSHGoxXjhdi4xU4pwr+2AyolcSe9LZeKuTGdQRWkc4h8SiEzRVmG9kE9d05s7D@vger.kernel.org
X-Gm-Message-State: AOJu0YzRb4r2S7ZGCJMXoeFhf/vfSnFmcHIQLlSU/fyknmn4wOk7D3+v
	m+4nG7jfebu44mSexcKo0xSzsJQMc+NDn9xBNpZWvWJvkf75KMJMPZwsfZczv1oqwUP3JfttPfP
	1cmquj801NpHkTThqdSD6ShkDdtCXPTTVxQ9y/qBnYg==
X-Gm-Gg: ASbGncuItNUFo4RTxS6OlM58d2riVx+KUsdMZDaH0C6DSutrZlqZkg2HFhgiHM4nWTi
	cvXFOWAMNKVT4rum/CvghahsMMdFMXY0l6U5Ae/kj99RVpGLs0fNo6HM3aAhBM0zXMk5pAKbKkI
	j5Q+TD7THZIukdHDWIq84BQiHu4nI1EaSKFK7v3DYHZ4hi2NEPWBke4jlVvzZMCa0aqRd8qwvwJ
	0joXXWJ7n6UquMgalKKtOiZ/UiyVLejKGr2WkUkEYZSZciT20pVrYNe9FZFGPgMjdGcYGmdRoAa
	YWahFv4baaQWxrtToA==
X-Google-Smtp-Source: AGHT+IF7c3FwP32os7g5g3nnhez/YGj7H7f6SIZxDU5kfQ8IXpiNDCY1vtNVgOkbueh7+ta7vJxNffCoSjVaHg45kvo=
X-Received: by 2002:a05:6512:33cd:b0:594:2f72:2f89 with SMTP id
 2adb3069b0e04-5944931cd2dmr762954e87.9.1762420649935; Thu, 06 Nov 2025
 01:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local> <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
In-Reply-To: <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 10:17:18 +0100
X-Gm-Features: AWmQ_bmcyOKjGadcgDMVTcigTKt7NE2VAzo9CGC8_ABY9cTLzN8m_BWUJEhFcDU
Message-ID: <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:08=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> On Wed, Nov 05, 2025 at 05:55:49PM +0100, Marco Crivellari wrote:
> > The code is using system_wq, this is the per-cpu workqueue. This change=
 will
> > only replace system_wq with system_percpu_wq. So the behavior is the sa=
me as
> > before.
>
> What does that mean?
>
> We're going away from system_wq in favor or system_percpu_wq? Or?
>


It's just a "rename" from system_wq to system_percpu_wq.
system_percpu_wq is a per-cpu workqueue, exactly as system_wq.

But in a few release cycles system_wq will be removed from the code.

If you want to have more details, you can read this discussion:

https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

> It is not clear to me what the issue is what the new correct way should b=
e...

There is no issue, except that system_wq will be removed. In order to
achieve the same result as system_wq, the correct workqueue to use
is system_percpu_wq.

As you can see from:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

system_percpu_wq is defined as a per-cpu workqueue, exactly as system_wq.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

