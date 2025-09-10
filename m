Return-Path: <linux-edac+bounces-4783-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC12B51B78
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2A518952AF
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED431AF37;
	Wed, 10 Sep 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UlCTclhX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272730F800
	for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517746; cv=none; b=dJtKEP/lbxQvPcu42bdiGd/URgAUrmJPLBgyD10C+mCkR6aeUxoFK9c/3jv13gwiDyiTkhWpXIEHtnbItDt1JIYpEOSyg44INpM0pvyTgHNm8+bKAS4x+3dy6wb9rwaFcuywhqlXyxVz6yxB1CBrjGpKkO13r97IDpZkBpRG+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517746; c=relaxed/simple;
	bh=lLWfzen6uM2hFlERHK9rDtfJhTMmwaVbEcunW4cxdpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1aAgjrbn+UTyDxqlYKfKVvJAYAhRVoIccLXxccCBe4s2ILSlaWkC0Ivo5b5Vln1jDTEV7shGGKa8MIDpiTegy9dKYnlAnjiquhm3Kara2BBci7f9Fyf0ZJCSzYSwDN8nENoxflvYjfurOuc3lDUP47nhbO7V05EkIY1FuzMlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UlCTclhX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dea538b826so5832201f8f.2
        for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757517743; x=1758122543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kVn5qvi+EQ4miZEc1V5J3/t7DCygziEcYhq/1So6cXk=;
        b=UlCTclhXEy333jv+7DY8gUvdr7yo0wIE9boGsgkEYAFpjpTqGM6NVFGQuMAH0T1azD
         bAboTOKihon2juLV+Z2bPnToDNknAEq9vxp1b10ik8w3Uwl5OCJ6WwUK6BV7UN7JE5PH
         9uo9dXF78+8YStv5m9MAkqlJoDT7Jdp5omREXzGG1eL0cSt4ydz5aJBBmYnwymDV5z2W
         UYbn+B0Qe6afE/d30qOYj/AIVd6PGxLpC3zWDHVFqTdUJIKWl39WMm6aCahsEj0Sbtbf
         z+GEFdfLJZy7o5RwUezY/wrZTIqyIZZgB+oJUs8XoubFwTFyeJvLgDGYKqX9YZSGcWId
         aZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517743; x=1758122543;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVn5qvi+EQ4miZEc1V5J3/t7DCygziEcYhq/1So6cXk=;
        b=v0kJ7cllzv5+bULThKaDyELHQpUdFbBUzZaq4GWN1sf4afiDBoJeeEg9/jDcnaxB71
         6mAe6QP7QhT7uyqdM6kacT0syqgvQAJckbWG5mfPW1duQ5vf3s9yOJ63k8g6zqAY42zf
         B53IW0lmyS6O/YdE7/ej6RCLYEBiXOmpYbZ20YT5BH4hZ4tpjJdQQ612CWeyKMOCjxM5
         jI069Ol4ra1mgs0eF3ycK3UWUXlds4FTUIdkHL2pgj0vj+ZdNorN2ZxZFGF2vNB70d6r
         Qy1Yj9QO3VERtU2hH3tduBct5k/xemVxfUOG/EZ3BsZ4FMdyjVIt8yMKOKTm2F7C1mWk
         nVvg==
X-Forwarded-Encrypted: i=1; AJvYcCV+if5BvBFHxvPTioU2SvsY0a6uWeG6EcLD2WRiuuS2dtxfRvtj6b424lO9bB7JxYPRYmkQFi3rS/j1@vger.kernel.org
X-Gm-Message-State: AOJu0YwdANTK/axrBV9bLwHAzuiX3lxSJuQqgwPnH1aDPXlkZEfx7/CP
	B/TEg324JAVXHj83P7SKGXdmu1XDTf0lmIPMyxfWyrLADpAXHuRn340kR0JLlKau+nQ=
X-Gm-Gg: ASbGnctB1UoqG939i5jPPALr/U2b6ha7qCnRnXPn0R9NncVjd3HX9j8g91ht1YFZGDH
	Z16xbqMWwmatL8NQSwyF5n7sE34WPNdBxMtakBTOqw9quSEeD2dhqFhKkgFxTbVpaLAmirCUtCu
	SbCAYd8ZczxUdGe3Xsdj7sTXJfNE4p/xWjeYmcCtBzS/xTS+LivEK7umLmuZwNsX5SQ9d1LuQd+
	UzKudLvH0U/pi+yFtRLFTu6TfdMl+puP/pIO+kjjxdnxamIbTUwEuphQ2Xdb0Nc/C6N27toAmZK
	ifEAaVgTT61g5LDSbeQg6ds/Sf37jOGvJ08fsYx6bT/4Pp0PT6YpPuJwMGn/vg9KAc9m9/Ph5a/
	Yig80bH0Ne3O0YNAa73jnYnKF8WwU27UVIVEVavYEtUTdUO83iwnJzTZ0C5QAGfFXfec=
X-Google-Smtp-Source: AGHT+IE/8wph2kz3bIbRx4/AeV456AfOXpfFA7Jm9nOBSvU/86K2GyIBZVHWyi1ESzO5NTuh6EwNuQ==
X-Received: by 2002:a05:6000:310d:b0:3e5:a68:bdc5 with SMTP id ffacd0b85a97d-3e63736c735mr14047737f8f.13.1757517742726;
        Wed, 10 Sep 2025 08:22:22 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f5d7sm7136215f8f.53.2025.09.10.08.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:22:22 -0700 (PDT)
Message-ID: <e46b51af-2c18-4e8c-9843-661b12c5df5e@suse.com>
Date: Wed, 10 Sep 2025 18:22:09 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] x86/mce: Add clear_bank() helper
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-7-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-7-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> Add a helper at the end of the MCA polling function to collect vendor
> and/or feature actions.
> 
> Start with a basic skeleton for now. Actions for AMD thresholding and
> deferred errors will be added later.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


