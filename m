Return-Path: <linux-edac+bounces-105-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB37FA8E8
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9AB20EBD
	for <lists+linux-edac@lfdr.de>; Mon, 27 Nov 2023 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6343C46E;
	Mon, 27 Nov 2023 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs/8rJOX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A5198;
	Mon, 27 Nov 2023 10:23:09 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35cb8fe4666so760335ab.1;
        Mon, 27 Nov 2023 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109388; x=1701714188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRI7cWlvOkyNkuDPrfXGivTVffcdI2V+Vot+f9MkWGg=;
        b=bs/8rJOXj01g00QbejC60avn/iUjsYjCtQhtXbHpyfQ7ZHrYAiAbjc9DBYnYZrMXT9
         CUUuBsgOfnJOO/24mx2iEtkvoR16YLjnf5V8OZGhmvTUa5R0SpfMeytD6h6ZBo+xOJTk
         JIUfuNlAq06JFKYmGGXqopBbVFWgjUXIfCoAl1TQqDh8Tvx+cTkw7SOMxBYnNtYplYE1
         Rh8nhYpsB2754mAuKKVF/KRZBgjJL8CFgEkLia44CC7Uz9Rt8WANJ2uiex+MmVUn72HQ
         PjSNVRfbmxjp8OTYFWGOKEFnvwv4Onvkx+t72EAszDThDxubAZV5VAXCalUyI+i1ou+H
         Dabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109388; x=1701714188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRI7cWlvOkyNkuDPrfXGivTVffcdI2V+Vot+f9MkWGg=;
        b=LjFc9mO9cfipKADJrztI3C/BnWfuRt2aYPMx263+gsrWQf+VTGfbDDZqC5Faqux3qD
         I0eNSodmsHrGLkERcOBST/79rIrTHXQLjKZixuHuAv6HVTJSJtRSrY0jzddry3Vn/ATd
         n3x5IC9eMXhi/XSKPahXqbSY+dw8nRdf3T/ZZS6YjdTdGKWULlHBJKggnGRJIZIXRzeu
         E1+qtOjquqpeJEdPNGk9vs67KCPab4X8j+Cqsbmsb2S1i+Flsu86Pg98dLn6yUyEmmtb
         Q/yKoFf0g54QBf+C2QT8B4vHNkBDXQmxIqoYmOUUjJj6c/V5A9gSClH+wgCEW6gJ60tv
         L0wA==
X-Gm-Message-State: AOJu0YyDSfd3uc+8Bq380Ma9uPqE3DYMvPttsmdSSoQE0dk1STAGtKbF
	XyP/o95IsorjfUBe3sYkVO1Ptjg9iCo=
X-Google-Smtp-Source: AGHT+IFw2AHP+33vEEsm3DpKrdLapr09lmZwO4DhjBB6CLzAkroRuckY0uVMI7Ec4ltxP/lFPFc8uQ==
X-Received: by 2002:a05:6e02:12b2:b0:35c:963b:a018 with SMTP id f18-20020a056e0212b200b0035c963ba018mr6289252ilr.0.1701109388238;
        Mon, 27 Nov 2023 10:23:08 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id v1-20020a632f01000000b005898df17ea4sm7863665pgv.27.2023.11.27.10.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:23:07 -0800 (PST)
Message-ID: <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
Date: Mon, 27 Nov 2023 23:53:02 +0530
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
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/23 22:44, Borislav Petkov wrote:
> On Fri, Nov 10, 2023 at 02:51:57AM +0530, Abhinav Singh wrote:
>> Sparse static analysis tools generate a warning with this message
>> "Using plain integer as NULL pointer". In this case this warning is
>> being shown because we are trying to initialize  pointer to NULL using
>> integer value 0.
> 
> And that is a problem because?
> 

Hello, thanks for reviewing this. As of now this is only a warning issue 
in kernel. I saw this post by linus 
https://www.spinics.net/lists/linux-sparse/msg10066.html and thought of 
submitting a patch. Also a similar patch of mine got accepted 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2560740.html, 
so thought about opening this one as well.

Thank You,
Abhinav Singh

