Return-Path: <linux-edac+bounces-5655-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB0QCU7Yb2kKSwAAu9opvQ
	(envelope-from <linux-edac+bounces-5655-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jan 2026 20:32:30 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3584A76D
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jan 2026 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC190DCA3
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jan 2026 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790A4657DD;
	Tue, 20 Jan 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lHA8HEE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A93314C8
	for <linux-edac@vger.kernel.org>; Tue, 20 Jan 2026 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926535; cv=pass; b=TUwf0NtVyoqwDSgei7gBYszNOtklWnwCflXy6ZnN0buh2qyiACspOGB3POlL50EEDVRaEAgJUTna1QQGQzbBwa8/VC0/cPHyXgf+7flOlbWGj47SoXNhpqEsfE4OO3B5zadh4u8z8l/t/4WloYLweeswuXiQgHSZUgRwbZYLGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926535; c=relaxed/simple;
	bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmhLSgTgdWsQ+e/hTfiwRdPv44LTG3XHHokWdqiCSyo1g66bRRfju1nPBwJaAalHpts+Z3wq6kPYDuVgRX/j//eJoWIifgrcENAfariPvq34CXr/AYRE5LcSNZjb+DQgQls1NqAoSZbHbklkUcsrsPnE+lqyicsTcSdJiXnn0ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lHA8HEE; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801cf7c2c7so147015e9.1
        for <linux-edac@vger.kernel.org>; Tue, 20 Jan 2026 08:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768926531; cv=none;
        d=google.com; s=arc-20240605;
        b=AFHHIIzs3tlVpTNO6ygZwWxhjfKaYDx+k3iF6bGQD8TaA8U9mLEj7UyqEi/Y0vcNXK
         WnlNn13XTOGgvfhCCbLYZaCqUzxk8i7VqItevEuTI2RS4CWm9+he/d95l2Eg9Eg+RKHp
         Fd0bTDdAjlK9muVQdsXT4aKqI0zZN1B4cWPBK0zGqw+G/Kj48lI/w6sKTAz+EP9YfKQ5
         VR+5WUC6sWs0mMDuFwyuWYKHDpWX6GXaWQdWjvX58wIizUKg4lQ795Xub02Mx4Ud/Ndl
         HRt/7JnLYiGZocDqzqEbTxXjnsrhHgQ785xgBY7zRWMEpUDUrwNRRXoNmfwp+mSgOlSO
         l/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
        fh=VountLAoHnDqhNp7jqz2zTt5Q3sVrwaid6aubjKhJyY=;
        b=IRaoJqiF6DwB4qeo3W9XaeacSxvQ97IT3yKCdJKnN9kAocc5rCQi5KZ9XquBgyl2P2
         K+tRB6i5h0MVF0U9vQe9M9tCZNoN3j4wyhMlq6TufaFrJBXizCveAveTvoPJj3gajiau
         W/bWC+D89/xDhSukr3HdO/Y654pdJAv+6zCpnxens6VeCef8UpFVWyyPTFDdCQK0zgg9
         29frCi8wSH+SAGdbt6Vd9jzmYERGCBTkg3xU4WaTQLjryCMAMf4P63xb3lfb/XeoNBq3
         O9TKDrISr8A8XVl4B5MhKrowen42HUERzdJi2xKBsaqLxhsKOpWid/VzAtFlCyjn7Jkg
         dKNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768926531; x=1769531331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
        b=4lHA8HEEeZgP/YUBLDBV82SFnUFOrX7ylbWOuMGnNSNoaKA04+jhRgmZ+qhYOYg99+
         4/q0soxE3Pa2XFcrYLmgKbAlJzzUeXdCerbKtzNXuFNh8r+/cTLMnFBao6OJleTZCeIz
         7ZaN1ml6p0rnTuTI8HhEKdPtwtLvCZI/E10j4e3HUipvZOeye4xd57FoHWSkO5k0Jg9w
         HaS35CLHn17cCXxobQzdoK4p7kDuKI73MP/UC6nfSP6Ged813+pG2rFFedOjIIWn2T9I
         JhJM5JOb/kOG+hZf3ZnrAuZ2+p5MpEP7yBAo4Y5RiLM9Ie9JT+0EVbUUcW/ZVoJ9Ub/R
         hIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926531; x=1769531331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
        b=ivNAOTjh0ow73cVEycFSCjRpxSEYAYFW3cXrFGQhbyktlYv2HJVHPVa4WsKqQXSAbX
         xZur91MIZbvGY5SN3al2+0ZOGt/BCq8J48ya9qIB0e0mZN1Q+/vAWwLCdIQ3pRTdd6K6
         ZNoZ0tHexar/xwjXDg5heBNkfo6g7FZerkElOFBXf4OO4Ugk8MX2LjCdiUBd2+bgtHo6
         bC7THe4I7nCGACVTQWDMCjApPWdkFwNwq2GLX3HORSjB4mHjvth0X2PfgEb+ClkCDmVG
         9vvNxeb8lGjiG9nCJpjM7qEbWbryl1avgxX82UcBYYWqDZqfxLiT1G8Q4oHEqOYAHrxa
         IxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAyq5TSIIvSxxAdPxy0r4OVV5qdVffIdWFPQ6OYRm/H3oFnjZHicsTnqwa2WDppgZLX25Hk2qZmlfZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwpes6PUfoiqXxCmeGqCy0mI2UFvYJRh6SJevuF+sfXSy07er
	D/4GdeDUD3WEUcFs5ppORAqfxsrFbfTrHgjmfDdd7YxWF8m3G5hBfb4xYjUDOaQcwYKlb1X0tzH
	2MnpF+6aFtWwFnCmlT7jnu6UaLAhXogOUoadqy8aU
X-Gm-Gg: AY/fxX5HD6HEc0sYhl45w+AL0H8qDXGjPH9IkyrRk2XVxxdS++fhgXu/bmzA7XphxiE
	XHIcA6ha8utwo92QruuUnA4zS0jrpTQ0U4LSjI+Sgp8EjkszKCTy9wSHLDPSqeb4tBlviVgAPt1
	tkBcLAtCYtymVaBjpdqX9yEpHeR/T/tizzoVPMW8N/ZSNFRYiMdah4rjUoO+fdIqz0uwD1736qD
	mrfzIDELy1HiEJXMrfLScYsntQUHtt3ppxnphHmaW96IGd12tdklXdQ8t6XL9uCE0IiGsKctcP/
	uvUPfPR4sBQGaAwdf2Ic7AL9bz9E
X-Received: by 2002:a05:600c:198b:b0:47e:dc0a:8591 with SMTP id
 5b1f17b1804b1-4802788e239mr2686005e9.2.1768926530251; Tue, 20 Jan 2026
 08:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102184434.2406-1-ankita@nvidia.com> <CACw3F51k=sFtXB1JE3HCcXP6EA0Tt4Yf44VUi3JLz0bgW-aArQ@mail.gmail.com>
 <SA1PR12MB71997E2E101E55CDE65EA6B3B08AA@SA1PR12MB7199.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB71997E2E101E55CDE65EA6B3B08AA@SA1PR12MB7199.namprd12.prod.outlook.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 20 Jan 2026 08:28:38 -0800
X-Gm-Features: AZwV_Qi-sOyZ-R41AFqxYbo27tCfgIMGnJS7jLDAEJnKTv2-_C3tqbgzg63dbdA
Message-ID: <CACw3F51qrBXnN370Btk7=bcKU7s44nmQYfN=EAfq25MondRUNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: Implement ECC handling for pfn with no struct page
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Aniket Agashe <aniketa@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"rafael@kernel.org" <rafael@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, 
	"mchehab@kernel.org" <mchehab@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "alex@shazbot.org" <alex@shazbot.org>, Neo Jia <cjia@nvidia.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Dheeraj Nigam <dnigam@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>, 
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5655-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[nvidia.com,huawei.com,gmail.com,linux-foundation.org,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,intel.com,alien8.de,shazbot.org,vger.kernel.org,kvack.org,amd.com,baylibre.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6D3584A76D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 9:36=E2=80=AFPM Ankit Agrawal <ankita@nvidia.com> w=
rote:
>
> >>
> >> v2 -> v3
> >> - Rebased to v6.17-rc7.
> >> - Skipped the unmapping of PFNMAP during reception of poison. Suggeste=
d by
> >> Jason Gunthorpe, Jiaqi Yan, Vikram Sethi (Thanks!)
> >> - Updated the check to prevent multiple registration to the same PFN
> >> range using interval_tree_iter_first. Thanks Shameer Kolothum for the
> >> suggestion.
> >> - Removed the callback function in the nvgrace-gpu requiring tracking =
of
> >> poisoned PFN as it isn't required anymore.
> >
> > Hi Ankit,
> >
> >
> > I get that for nvgrace-gpu driver, you removed pfn_address_space_ops
> > because there is no need to unmap poisoned HBM page.
> >
> > What about the nvgrace-egm driver? Now that you removed the
> > pfn_address_space_ops callback from pfn_address_space in [1], how can
> > nvgrace-egm driver know the poisoned EGM pages at runtime?
> >
> > I expect the functionality to return retired pages should also include
> > runtime poisoned pages, which are not in the list queried from
> > egm-retired-pages-data-base during initialization. Or maybe my
> > expection is wrong/obsolete?
>
> Hi Jiaqi, yes the EGM code will include consideration for runtime
> poisoned pages as well. It will now instead make use of the
> pfn_to_vma_pgoff callback merged through https://github.com/torvalds/linu=
x/commit/e6dbcb7c0e7b508d443a9aa6f77f63a2f83b1ae4

Thank you! Sorry I wasn't following that thread closely and missed it.

>
> > [1] https://lore.kernel.org/linux-mm/20230920140210.12663-2-ankita@nvid=
ia.com
> > [2] https://lore.kernel.org/kvm/20250904040828.319452-12-ankita@nvidia.=
com
>

