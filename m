Return-Path: <linux-edac+bounces-5270-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F2C23D20
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 09:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852823AC652
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EB305E02;
	Fri, 31 Oct 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VTwMkIR1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1383043C8
	for <linux-edac@vger.kernel.org>; Fri, 31 Oct 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899250; cv=none; b=OPChvoqLueDd2FWbTiRycobLhWZHpFX2X9zwnfXTOL/UXiDBn5FDCfGoCWCgz0c4BU7iZ5B8ma6jB40fawJGFSUQ5Om4V9sLRykMcbmxpCQGZkYlwH1+AQbYTF/Hx5Spx8O+GAZuzzelLEk0B62sGNilvmSHuNeKX/HndKNdpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899250; c=relaxed/simple;
	bh=lVQsmI/OgcGtefcLtFfLf1leQyCYm0kn4f7Js5h7gO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouIGn4824VZhNtJD7X+ehqRpaJPT7jF4bc+eOUp3xlQUnqHQPcTNaj+a2ghqhwxNtJrZyy6wTUT6JTq3EbLQmD6SzH1B42nAJVaqORj3CKgEOnLlzJjjkWwRI5JpGMKOyGZb7/tETXAXiT5p6MLaws+jBh6Cqo5hgdQs0KEbkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VTwMkIR1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso24353065e9.0
        for <linux-edac@vger.kernel.org>; Fri, 31 Oct 2025 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899246; x=1762504046; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/fYaZtBikFS6oNzHl/Bdj60BD7iQqSjLDzNr7ZdDK4=;
        b=VTwMkIR1VeHb34IVXW5RjFZ5L2uhvkov+OYofjiegNANlWpv3EuvrJAeQu87V6/fX3
         52EhifGNPAlypuWPbkKZ6F5OOUphcV72qQ6J+ReZE+um53bEQs/uPAbgHfF0xF9B6TRp
         Ze3wtxMWxYLOE7w1cz2NZdKGOfqX0WGmVCOzMCnj2caN8UvByuoE7ajwBeEYgVw7t9AZ
         iWo5GbUj6rqSq2+EAP0Qz+YbuhT7YYAC4HDPX17qUTaw5Uu1J4qjJUOPeknxIJA5HyCZ
         wFlRckI875ozN6ZZos8cVTqxnHcW+CWaPKQIuIEl5ZAZ4wKFV2cN+BzoOKfZ1gN+cor4
         51oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899246; x=1762504046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/fYaZtBikFS6oNzHl/Bdj60BD7iQqSjLDzNr7ZdDK4=;
        b=tUzdEXbFNaA6arJEbil5W2yXs0dCkbDTjFj6Dl8+WlgztWyQ19CmBBeYDAHrrSRtBG
         T55oQahG620XXpE5Ntp07IsW+75WDOX1SKy0qaqDLLl5hwpOYTh41XTM6R+ONuVsXS6C
         IKSBXfUc5MxXZq5mhz9gCZtttqbvZ9rZpaY6t6KQkSStu46Bs4jtFCvX32eCp8LU2yCF
         abgZWdzp5PoAQm2Wtd8Po/456EmNXYJWG1b9s+g5iEF7hdpqxK0pqfJxBbiy+8gX/5Vd
         aKrh+VE7tkuXe9A2BoA2aaM/a8jtA91LUqtyvXKig3ICcd8laLtIDSeVKO/ktE5Su8jZ
         qpSg==
X-Forwarded-Encrypted: i=1; AJvYcCUEQJs0gJEyQYr0dvzPmZieFlPVVJF0kvWGeLDadLZ32CImlW9Fj82dXGPLKsMA9wIwvu/zao/n+Y0f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82F0DaI+M+ctJJarpiJcujjDxUhQd4tocvxjE5n+I1hIfeBYo
	S+2lrttnug7rNHTH4m9VAgVP/Yo98FVhIi/gXb8jHnMav9U5oFBgp1PdGj0uO5NHDMw=
X-Gm-Gg: ASbGncvtEunCZDFFEPyDLbfAoqs2yjjnqgOpT78D90eDeQRlyU3LqT4HSQYfyaYM9rK
	zW5JKrzxgwsh4Kr+63vXDS0T6qCRIkua6vBqNjc76cIMez+5t9xyBysdH41wQA+3LzC0GGEWPK4
	m9dxQT2zt/s8aXNL5GkoIJlDZW1xcbrzYFWrm+gxacxxqYdoQip5suxy6+Th7/WESRp1WUvIbIT
	UFrgRvCzLiqm6GODgaSRT7PDIOctQbrvxK9YHvpbsdGY06mK8FfVbHs3QnZ5Dgz0PBgY1hniN1K
	SWnJr/+9q/N0tqBxT+c+8H7C93EasDyPRHSztA4Tl2adk5LJK6bQxv66T0VDYavHxEHV/W//NHg
	lhb/NqF92XAwvuPjCjvA8EoyeD+4jn9VH3mLJhtKUzR7jUmgTxK/0VG4nqIUtq+nWXet7h9YYV9
	hvRVkn2scDFbkH7pDgZ5fPbQ24
X-Google-Smtp-Source: AGHT+IFSgi5NgEp0bWNzIHDj0wUEorxSLRV/wRdPuexvpAZjr+shE6+j17OmyoRsqSiC8CijMQFTMA==
X-Received: by 2002:a05:6000:26c5:b0:427:580:99a7 with SMTP id ffacd0b85a97d-429bd6b222dmr2082292f8f.59.1761899241764;
        Fri, 31 Oct 2025 01:27:21 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142e7dsm2242752f8f.17.2025.10.31.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:27:21 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:27:14 +0100
From: Michal Hocko <mhocko@suse.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Aniket Agashe <aniketa@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Matt Ochs <mochs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"david@redhat.com" <david@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"alex@shazbot.org" <alex@shazbot.org>, Neo Jia <cjia@nvidia.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] mm: handle poisoning of pfn without struct pages
Message-ID: <aQRy4rafpvo-W-j6@tiehlicka>
References: <20251026141919.2261-1-ankita@nvidia.com>
 <20251026141919.2261-3-ankita@nvidia.com>
 <20251027172620.d764b8e0eab34abd427d7945@linux-foundation.org>
 <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>

On Wed 29-10-25 03:15:08, Ankit Agrawal wrote:
> >> +static void add_to_kill_pfn(struct task_struct *tsk,
> >> +                         struct vm_area_struct *vma,
> >> +                         struct list_head *to_kill,
> >> +                         unsigned long pfn)
> >> +{
> >> +     struct to_kill *tk;
> >> +
> >> +     tk = kmalloc(sizeof(*tk), GFP_ATOMIC);
> >> +     if (!tk)
> >> +             return;
> >
> > This is unfortunate.  GFP_ATOMIC is unreliable and we silently behave
> > as if it worked OK.
> 
> Got it. I'll mark this as a failure case.

why do you need to batch all processes and kill them at once? Can you
just kill one by one?
-- 
Michal Hocko
SUSE Labs

