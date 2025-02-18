Return-Path: <linux-edac+bounces-3115-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3956A3914D
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 04:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BCA3B2383
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2A17A5BE;
	Tue, 18 Feb 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NqAZFisO"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D018E1F;
	Tue, 18 Feb 2025 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849396; cv=none; b=IsMhHRBE+OFHF7LXkW5sbAUgMGxp4BUuBbebPv0/hqvI6P/+MVywfaNZQCfVyCGaCfD8wledmhtnSOR4qoHXrsrcG3Xz4WwNKsIGCj2JS+6EEsbI5/qcys3CVX6+vjWchUs/AyebOLJNjT/1GTGxw/dicbeKYQIoM3SqDDv5iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849396; c=relaxed/simple;
	bh=g3BhvqrlxwkwxmHeL7ZSMFE5wTisHlVnwZFSl6LGZ7M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TbayMH3kOOcZ5Vs2Vh8Y/WHBlVxSyGfJ+eOs0wsfen3LDs2Q6Boa9xKNYoIYIY5sF/oKUmdAfCaqFBEdMGlTo1sCAN5rILaZcZuhSYaLClJfD2g7NRFX8Ci+v6wTsu3ji/O4isrzMlpmZ4cZPM+WyurtOCwsS8/89UbvWACzAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NqAZFisO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC412C4CEE6;
	Tue, 18 Feb 2025 03:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739849395;
	bh=g3BhvqrlxwkwxmHeL7ZSMFE5wTisHlVnwZFSl6LGZ7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NqAZFisOE1Ko730kfgTqxzNRt3JfL0GJdNVL3Q++eyo/jXONH+UKWsQI5OC2T23uF
	 cGR+bgCWHOqZ5YVtIugAS7MEYP1vFAS994zk72NT6sahatVEgCFLmOT/eDUaIxo9Wv
	 5xhFp62inPy6ynTjnKMN9BFeAYTAW6RJDJK97M5Q=
Date: Mon, 17 Feb 2025 19:29:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, bp@alien8.de, nao.horiguchi@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linmiaohe@huawei.com, peterz@infradead.org,
 jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-Id: <20250217192954.b64f88bbd79ba83ecf05110a@linux-foundation.org>
In-Reply-To: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:33:30 +0800 Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> This patch addresses three regressions identified in memory failure
> handling, as discovered using ras-tools[1]:

Thanks.  I added these to mm.git for further exposure and testing. 
They do appear to be more an x86 thing so I'll do the usual thing: if
they later turn up in the x86 tree I shall drop the mm.git copies.  

