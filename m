Return-Path: <linux-edac+bounces-3319-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C88CA579FA
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 12:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7D7A4401
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B11B0F34;
	Sat,  8 Mar 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uUfZryQk"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB961624F7;
	Sat,  8 Mar 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741433261; cv=none; b=JPytntWe3+nRwRKPZCSO5P93oYav8m93awXzjiXbgEsPQI+RzzKM3dy+AZlS/YTw+nP9oVFvKi1mAsQTW2idqBBXk0+VrqpZdH7RsgPlQ9Se2B4ZGnJzFNIXa08cAuCekYY8MTUjlA/tRFpMfvRU97wzAUaQ1QCV7ogTQm6H9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741433261; c=relaxed/simple;
	bh=77pa/0u+spJdnTck61KtUEn2q1EuxIPaLyUfXm1OYLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjHL1nEHbSbo7dmlAdizrPZ/K4zdN8Bvbgfc5M5W4suMzpylfJ4nAEHnj6ulx5Rk5OPg4W+wmyFiwCmo+Tvcrl+PaZ02ACfY1xkjLCzY+FassR1uORcm9+kP9z+lZ94da/wRgJqXLEhD3w3UeNXExGF/qQ6zeHgGh0UUphD64b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uUfZryQk; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741433250; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r6hK8RRJINhih5PCH8DXk4WruEB7j98b+Guc6p08Ch8=;
	b=uUfZryQkJLp9monZ8RMRcgu4Yj7WXc9Wn7VOZ8Dwa4D6NCWVZmKI1Lnc9Tw6xNdX2Qr4oVfKTdpYV0HpD9ygr6gpeAIwBAcjSAGOZCdYth4NpG7Si8HIjgn/5hdUJDSS+a33xRm4oMGscArzC0Vw4M9D+OQlUozkE3SGFn2hvtM=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQuhv-O_1741433247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Mar 2025 19:27:28 +0800
Message-ID: <0f4dfbde-74a5-451d-8764-cc7767596654@linux.alibaba.com>
Date: Sat, 8 Mar 2025 19:27:26 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
 <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
 <SJ1PR11MB6083654405F2721E5AA0C1F2FCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250307224645.GKZ8t3VX5a5FhqNyZG@fat_crate.local>
 <SJ1PR11MB6083223A3175F7A84EC4DDDFFCD52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250307232230.GMZ8t_tja324AQqYME@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250307232230.GMZ8t_tja324AQqYME@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/8 07:22, Borislav Petkov 写道:
> On Fri, Mar 07, 2025 at 11:11:26PM +0000, Luck, Tony wrote:
>> As for "explicit markup" I don't think it would be better to decorate
>> every get_user() and copy_from_user() with some "this one can
>> recover from #MC"
> 
> I don't mean every function - I mean what we had there with EX_TYPE_UACCESS.
> That is explicit and unambiguous. Proving that is_copy_from_user() is always
> correct is a lot harder.
> 
>> Note also that "what we had recently" was fragile, broke, and resulted
>> in this regression.
> 
> Because those exception types got renamed? Oh well, that should've been
> reverted actually but no one involved realized that MCE is using those.
> 
> And I'm not saying this is the only way to solve this. We could do something
> like collecting all addresses on which an MCE can be recoverable, for example.
> We haven't considered it that important... yet.
> 
> Looks like we're going to try this new is_copy_from_user() thing now and then
> see where it gets us.
> 
> So, after the commit message has been fixed:
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> I'm presuming, this is going through akpm...
> 

Thanks.
Shuai

