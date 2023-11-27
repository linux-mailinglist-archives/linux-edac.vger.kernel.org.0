Return-Path: <linux-edac+bounces-111-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478977FAB35
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 21:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02853281A61
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCEA45C0D;
	Mon, 27 Nov 2023 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG2Zu5Xs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963341BD;
	Mon, 27 Nov 2023 12:19:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so1280244b3a.1;
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701116352; x=1701721152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MJbv7/yM8IoZp5rE2NxjWnnGMEZpgKADKLpNiN2nLo=;
        b=hG2Zu5Xsa3LsAV5fEr6PDrEwSaXvQLPcDG3O+anLTeCLStbO9+igKgu0LHdwFbEyzB
         VMnOQwtgEKretAKvYrfCNdUchi5VP2s51Hxx/sgLmBfPYb0XFO2MMQMnTZLO0QIC+g2p
         iEMDK0xKylWsIQIbdZ9eGE02/zlo2yywdL5FbKJn51TY2GSCBktqjnX6uVc5IzyygbNP
         +Ht0UNp05J8MiIAhsN0oJxf9quBf892VwszD5Z+G60Mw/UR2KutdRSBRh0vMlwbPl6Kk
         K7lotIoNsC+SLzY9gx/KJ61xolIgThTeUamF3SWAjiBycAON5WOw7J/LMSNp7IdEN05y
         EDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116352; x=1701721152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MJbv7/yM8IoZp5rE2NxjWnnGMEZpgKADKLpNiN2nLo=;
        b=LPnqfJH6TyWNsl/2Nx8mR/tFj5cN1l3sLvnjHpk7bU8Nan7Fa0Hhqg75nsIYJDtQB6
         BsawsG9NmCgufwVCfMnn1PgNwkZo62/+7oOu35++AdiQ6hRezqv417peI4ePmXWG6Tci
         RuzCQCN0cjLbSpL/q7SGu/AP5jZTKhbP3ZdYHK8ag9y0+thvqiUrfn6TtQqcJ9a+Zp0E
         Wnwu/6z/cti/nLr8sw5eZ6ZuoBDsA65jBH/XJ5iOH2I95s0g8Pup4KVYTO17cQSG0yYv
         OiU9OaV2TSNtJAUY3kGkRjxluM8bb/WENaucr5RDNw3xvVrXfQl+Jrlpe09scKUwcXdD
         rhJw==
X-Gm-Message-State: AOJu0Yxog/MbTCakqSJQzbYUyoZB4i5no0eULfnHPXDP6D2AjGBH56Vr
	Ma+ppnaH0mXG3LRBQdSRx5k=
X-Google-Smtp-Source: AGHT+IGgAthcmJdLcAxnPF1mKTsZQwYQTddihmO/oR2hXQckOBKxsik/6r22n6oSt6f1b7tAAhta1g==
X-Received: by 2002:a05:6a00:3a19:b0:6cb:8347:c8b1 with SMTP id fj25-20020a056a003a1900b006cb8347c8b1mr16610584pfb.1.1701116352000;
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id c8-20020a62e808000000b006c341cf08f9sm7780689pfi.140.2023.11.27.12.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 12:19:10 -0800 (PST)
Message-ID: <af489962-705f-4a72-943d-ba3b46d64597@gmail.com>
Date: Tue, 28 Nov 2023 01:49:06 +0530
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
 <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
 <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
 <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
 <95fc95c8-dac6-4137-a9cd-29f27da64e41@gmail.com>
 <20231127200519.GHZWT2f2x76hMLR91V@fat_crate.local>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231127200519.GHZWT2f2x76hMLR91V@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 01:35, Borislav Petkov wrote:
> On Tue, Nov 28, 2023 at 12:23:54AM +0530, Abhinav Singh wrote:
>> Just to be correct this time, I need to put a reason why this needs to
>> be fixed, in the patch itself, right?
> 
> No, the commit message is perfectly fine for that.
> 

Okay, so I guess as of now there is no change needed, so I need not send 
a v2 patch, right?

Thank You,
Abhinav Singh

