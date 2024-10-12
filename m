Return-Path: <linux-edac+bounces-2022-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4799B736
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 23:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C471C20DBF
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 21:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F716C6A7;
	Sat, 12 Oct 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNTo4izL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247F149E17
	for <linux-edac@vger.kernel.org>; Sat, 12 Oct 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770321; cv=none; b=dn6ErN5CLTtChhnnQpASK620Qom1YtIDMm5FcI66I8Pt02t1UJnFoCorAuQplUqZ/6kvXK5HfN57VB6fOIiM8KQiY+xahHifWsydAqz6NVdX5KmwcIp0AJrhxVSUtXoPOnukosFMqVSixCGZLEmtesu9f1Yy79biF2PfqayWN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770321; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=aR7Idq8MelI5TrOmJAsXFNEr4kgmnniPnWDjtucygjVEqsvvk9IOhRN/Uou6hhH6iVMOGf2a2IADmE2VLotAstI06oyTjMZBfZBraBqiXFcyVaPceLnScFdTZFmp6eHPRmdBMirShMWHmNMSaaU/YEz0gIEpNG+c+w2L/sWF1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNTo4izL; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-208cf673b8dso33308395ad.3
        for <linux-edac@vger.kernel.org>; Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=VNTo4izLkny6YY1bzoZIQFTrx2vzWzlItreoXXRu5HdLzNJjRplpZvNpw1z0Ul0a3c
         tM9SUKyXJb+lqbQkWgpLE1zsGHUQq6EPz6uOQLzy1Gh/Mn5+51ZtWyi18BjAI1QKRTnJ
         B19CbDWYOpFWT5g7I16G31Jppx4LwYJ0swfcuj62+Sbk7vIV0VdJUTUwJ1nhLRZHZyE6
         uoz4h/TZIsj73i18YSCAoiJqHZZlwjZuhfK5uNtBcS7qUBZSuxjyKfKjKbATfBCRGir7
         6GSo6Zt8qNGlxxG7JsLs4ACnbZi/uH/Y+QGEbKCaPpcXZMOyg128bmC1LZbmcgrJiACM
         JnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=rhcA520buCIGGUrkmrYF+DWhYf1aFFKn68d/0/gcjkz1yOAkQthk2i9RKf6jscs2BI
         MUlmTlSv2oXWA8sdvkl7CFSoZqLMTAwP07MVeDOFr5e9PIA3sKA6Atwp8HC3F2AHfN3x
         1vOduWjKuhr+NdnqCjE5d3dnKocjqE6Yxbo5ZpspbqOY7ztr3eAfoi4vvFtEuY4oHVwW
         ZsTeZnhgJdoRVjXUh5pU5BUTsI1/1VoPGrdvRkg6hZ2n+Jn2TcrDpwzpuQLnBxgKyTQx
         M+t50OyKAHxXMgblcoKOmrG83CqdpLeX2tPlT5noENHsyOlu6yEaC+44qcj0i1HSEBQo
         qZ0Q==
X-Gm-Message-State: AOJu0YxMfVrcxX/GDlHMuYQSdMFveTk9G5P9pTgBumbZ65sTDhnKYBbI
	IdS/V07iZ3TEEfP9EHgDWvRk/a/F2hsjhe1QZ5mx5PXfXvAQCB3dQpQ/P3jy
X-Google-Smtp-Source: AGHT+IEbfFzChvaBUlo74d55hqndXlEzSI4Gg5PwM7v2DJMee5iqSCSxv/6ipXN83yNqhexDIlDPHQ==
X-Received: by 2002:a17:903:191:b0:20b:7f94:9d42 with SMTP id d9443c01a7336-20ca1458c33mr71833245ad.13.1728770319043;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212e42sm41481125ad.194.2024.10.12.14.58.38
        for <linux-edac@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
From: Josey Swihart <numbers056@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-edac@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey

