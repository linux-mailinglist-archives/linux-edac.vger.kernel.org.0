Return-Path: <linux-edac+bounces-3417-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4822A759B1
	for <lists+linux-edac@lfdr.de>; Sun, 30 Mar 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F08E3A7F17
	for <lists+linux-edac@lfdr.de>; Sun, 30 Mar 2025 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A2142E7C;
	Sun, 30 Mar 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natrix.lt header.i=@natrix.lt header.b="LTCT+3uV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D48821
	for <linux-edac@vger.kernel.org>; Sun, 30 Mar 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743332424; cv=none; b=H+UtkQ7VukbxNYEdxDqN9gRx9rWtHf43IjnC2Jz6/X3Mwiu7uFql1tNme+SlstSzrhTLND7IM8O+S9BT7S81sEUl5qOW23cPdGUCUHl8wCjKDjeGEnsIIOEMsfGr7mr5hj3mWuiCtQbBkwwiBtpI1xZvgIXm9Xci3o2KXIC76yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743332424; c=relaxed/simple;
	bh=9243ZElNqjKOsetJS4KqM5BXc9GNQOl9qyW++ooIIwo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gmhW3S8QqeT1sOLQ0F6aypUL6a7wfEDOyOTvkHHSN/FHdDwZwcS/C6Ml4j5Qx41x7Ke7mpNp7f08IgFg3EpS1cd5z9xS8y6eRlVAtkfMZ5V/NMmfuxx0GMtbAFcWPjJjq6KbxFBpzJv5cl5dkhb8tU2ygN+LXSvORLzuZysgncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=natrix.lt; spf=pass smtp.mailfrom=natrix.lt; dkim=pass (1024-bit key) header.d=natrix.lt header.i=@natrix.lt header.b=LTCT+3uV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=natrix.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natrix.lt
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso3121658a12.3
        for <linux-edac@vger.kernel.org>; Sun, 30 Mar 2025 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=natrix.lt; s=natrix.lt; t=1743332417; x=1743937217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYd29UpWvSIOQIWU0Zk8usl9SwxfWglW+4uMhZDQjdE=;
        b=LTCT+3uVcSA5/nFp01adC6j8W7Mj3yRSkPJGkUcNLIaqfti02KgspzYOeOgd2yOwwV
         7gZgDKU3PKFn1BUQOcSij7V7uE9HX6T9eChmR/akDo0jSMGCVZ/3AhvnuHsZGUKBCU2W
         v0AX8EcoUzzXcRgWdf1jtg6UpOWDvTgp/873M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743332417; x=1743937217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYd29UpWvSIOQIWU0Zk8usl9SwxfWglW+4uMhZDQjdE=;
        b=Cz8XW2v9tUbhdlpxVqXy6rL1k6q3QQwsfUfpvzn/ACtTAdyimNnZ5qQLzNaEuOu/vE
         oL3Vg/twIzZez0X5llcTuTZ0jMFohtj961s8aiGOMh7vWlZc7wZz9fYRgXjof6h5lZ2x
         T2SYXAphj7AeYLcplKNV71xQYIRhZ2VxML/Rr9a6xd1RNg29qIkTjK8ZSqye/bvHw7Zw
         t1b+tLv0NKQyAvrHli/yGGXsryMWw8ncuwcsN53nXUagEWe6BINQ95mr7zrIr3xSUchh
         U74zlODsFp8pMpAhG8K8VOkrJQgmWoFntns6KP0UuedEU7ZtWOGQovjSJ+aDAK5RocrS
         7PNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqVliS0KK8VHXKjUukNi5+B8GlDcZlf0OYrs7ceedkegYhi2Aya3zmSXE299S4605cPGVAJlqQlZWm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7R/0Jru0GOaw/Rv+ZtEGG1m7/Q7dO9fGqKT/MJLdbPTVxhBqk
	fqx2EGcF3UGhGPsJlE8jLyWqQSggx7TgIl+UUplTq1JuHmBJcGj4unjmOQv23rE=
X-Gm-Gg: ASbGnctOHABZ6rEhCQwHrwxJZJYHs/ADH4eKOBajgsYS+6VzAdn563bC3bfaLfG8J3p
	VWsoQIOukjOGCFo+bKkuyWqAAoXSwMugwlpzYF0JAkz7NokgNKXIfIe4tFehE/9Pwwgi0nIUsPT
	RuthFOMhgEtB2RADkDmXA6btTEfQfuOYT1xAH4QhGY09F1phAqXI/CipRzHj+fbo8w0rf1P4J6w
	FcvWaU0MNHTepkNtieDewyfprIkXtR0uq63z1LMByY3OZeEF6pmdDBT7O58TCSpD2QMR4pI7VUm
	cIgprhChCGFTlyrqQHalIAJnV+3tyZzmpN1Mb7y4V7/oKA2n
X-Google-Smtp-Source: AGHT+IEU4Km79gQKjBQieOCtbBxrZbgSdiZM/6dPAGM1WvO5o+rUho4UY4YpIZKNGUyMgx+yc0Judw==
X-Received: by 2002:a05:6402:5193:b0:5e7:9359:58cb with SMTP id 4fb4d7f45d1cf-5edfce76ad5mr5262780a12.11.1743332417153;
        Sun, 30 Mar 2025 04:00:17 -0700 (PDT)
Received: from [10.1.21.7] (beta.natrix.lt. [212.52.62.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16edc69sm4132477a12.35.2025.03.30.04.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 04:00:15 -0700 (PDT)
From: "=?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=" <zilvinas@natrix.lt>
X-Google-Original-From: =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zaltys@natrix.lt>
Message-ID: <af86f5e1-0d86-4b6f-8c51-01aa0511f919@natrix.lt>
Date: Sun, 30 Mar 2025 14:00:14 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory controller not showing half of the memory?
To: Borislav Petkov <bp@alien8.de>
Cc: mailinglist@reox.at, yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
 <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
 <e1b214f4-1093-4713-9ba6-3a9774ed4d63@natrix.lt>
 <20250330103906.GAZ-kfSjT1IqkH7nUs@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20250330103906.GAZ-kfSjT1IqkH7nUs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-03-30 13:39, Borislav Petkov wrote:
> Want me to add your tags to the patch:
> 
> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> 
> ?
> 

OK.

