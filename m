Return-Path: <linux-edac+bounces-4358-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24585B04607
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D0A3B689B
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317278F54;
	Mon, 14 Jul 2025 17:01:09 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235A18E3F;
	Mon, 14 Jul 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512469; cv=none; b=kWhqtHNO0+nxZcWtITTPKxFEWnQBMinY9eP+UcybGYVOdUaRH+sqASerMSV8zW1kaWDuFUULQ6qb3loezlffTq5WRTXmerLuGhUdgO1EUsAbq2/dvFdxcZKH/5dC7cNSFPYbRMs4WKV93kUgcIV6vdpcyzMgXgDdLc9kAFZg16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512469; c=relaxed/simple;
	bh=VNCop19lgatJ5NUre35iBgDYaIzmpeZaulW0f1G9qVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwSTmGCDYdQLeaoVW436GnwYBBwX4UZqoUzOdtUaxhfAspAgzcs9lSNPB5N677Gb7+ELNozrCOnqR72KVvwA9uhAEA7JvsiRu8ExMUXw29f8Tw8hcBVCg0wnjicd70iHttZV0CxA+Ior1ICAKYIAm58KxM+pCa3ozDPK39zctKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso800959666b.1;
        Mon, 14 Jul 2025 10:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512466; x=1753117266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB2RqLTCAyDCFZ1kco6l5j0ykXeItkR8kJIcsHz8sVE=;
        b=bSp1xzbzbxAMzBmdqEA/fCDGyk5oAIpK2KjULLaY/URhARZTw3V42ZnORevoEGdA+o
         xdtFMT9rw3ugfEdi/eImY0HaTUuYKi+Dme2GY/k8yu8OJKZCyfEwf2mU48hkgnoAl5or
         HRd/UkQ8ZZ5S4gYM5T1iAsxUdhfB0VITsRscvjy+NUkl4m0zhXGCTFaPe2A/lqRb6X6y
         8JVccMgczJE3pNifUt5OV2ADTXXzeud6Hnd0Kp/ULmx2YOdQsrgYu6oHUcGRXgMcOJnI
         eiqlDbAHCfPiWk5Ya4tYru7bTIvm+jzyzZ7TD5cbYa2X7F40GcBflO1nlh92BD9N861k
         d6AA==
X-Forwarded-Encrypted: i=1; AJvYcCUKt3uCO6aIKa/+foMZLWmUSQTJYNhYgvZCulWmJIDkouqlBCfsBSgDBiFRsVQ9YL0Sew/N8u/AMMmGRA==@vger.kernel.org, AJvYcCWWymhyZm7QKkxhD84NyiEIrCrOm29NMGaeC6s61zN3DUbxk228z454oiwNlEEZtb/OfUURfchAc0+j@vger.kernel.org, AJvYcCXqWEBrdMwXceg9um98uy4OQW5I6YnA7be42qq1RxbCf2447gOhgXzczK4obo2TbLVi+DuQEv4nijh4rwLv@vger.kernel.org, AJvYcCXwudfxIIDUAphSr2JfeyQsCLbDYo/MIxtW/b51PSJalCaB575scAEA9ylERYkh2Ba/AHGrVKOs56kf@vger.kernel.org
X-Gm-Message-State: AOJu0YxgE9jlr4cqDYWW0B73lUfV5D1ExKjI+h0ZMzTk85ZBCe8op0o7
	sloABjMOOTvjw6KLssNPMvbF2UwQ696JOva13pXu+ddxQM2JVvK9dxmX
X-Gm-Gg: ASbGncsV1hQApEqChpCEMFGDlH62qAH9eyP93OgGBULeuOJFkbLrDP97NWukqyT5hmp
	NdU8S1kH80WSi1O6jvUjrnWrHWPtGs1DAEtXuQV3UEEOntfytWLAcVgf4gIwPth7EfGs85sVKOx
	Zl7oMfUnmplHOplDiTN3Z6PVq1wjcQ1MI1Kq6kSkRszgroVqoBMXhxeNJzksc8WI3ItcboSEovz
	RNmhwVdzT8wFITeMEBUApzno0/aWeu1ss7lfy+8OlRYPcfsEKkA8cSa3yIT+L8RueDFxE+X9/Aa
	F76TsQ+T7CZOGSUUwaVH8qs87O366LBoE/xShiIX0xUbRn+5VEfxtFoORWHX+nIcdvDfoaU5pb8
	Qo3DdgPbo9k99
X-Google-Smtp-Source: AGHT+IHU7CWQJlu8BPwtEBMl2toEIJ7QpFn2iQtlHuu5WfBKYV5h6S8k8wIg53+6uFsvQmWkU1VApA==
X-Received: by 2002:a17:907:3d02:b0:ae3:696c:60a with SMTP id a640c23a62f3a-ae6fbf4248bmr1229354166b.8.1752512465650;
        Mon, 14 Jul 2025 10:01:05 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8313036sm834335466b.180.2025.07.14.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:01:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:01:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com, rafael@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, kbusch@kernel.org, rmikey@meta.com, kuba@kernel.org, 
	linux-edac@vger.kernel.org, mchehab@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] panic: taint flag for recoverable hardware errors
Message-ID: <esn3rake35agpqc6bvhmmka6adzzkjah4ipjd45t3zsdquwd6k@b2fvuwwjqoqy>
References: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
 <20250704111954.GBaGe42gY5_xADb17Z@fat_crate.local>
 <aGfFyktcuRV73Bl8@gmail.com>
 <20250704132518.GDaGfWPnAZI2FY8EnM@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704132518.GDaGfWPnAZI2FY8EnM@fat_crate.local>

Hello Boris,

On Fri, Jul 04, 2025 at 03:25:18PM +0200, Borislav Petkov wrote:
> On Fri, Jul 04, 2025 at 01:15:06PM +0100, Breno Leitao wrote:
> 
> > Anyway, I am happy to add this information somewhere else if you think
> > that taint is not the right place.
> 
> Documentation/admin-guide/kdump/vmcoreinfo.rst could be one place.

I've tested adding it GHES and it would solve the problem I am looking
for.

https://lore.kernel.org/all/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org/

I wasn't sure whether to include you in the "Suggested-by" field since
your idea was more general, but I added it anyway. Please let me know if
this doesn't accurately reflect your contribution.

Thanks for the guidance,
--breno

