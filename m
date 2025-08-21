Return-Path: <linux-edac+bounces-4634-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11178B300A6
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BF63B03A3
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815742DE6F8;
	Thu, 21 Aug 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AKYJcttA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0227602A
	for <linux-edac@vger.kernel.org>; Thu, 21 Aug 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795536; cv=none; b=MEDnjs+wAKwK2/AYRTZuVCFY2q3YzznyczrR5qbjYPaQpTF5C/EEXJlB0V1Vv33Q4gKRnv44T1dkbXwJyrid3yvszF2/VgoqeIASE+rca1gTjF4D14keHMIEDXIL1wkp4nuw+2OiHhoRyNGXw91P/BjxMypt8pf/q1LMbZPruDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795536; c=relaxed/simple;
	bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqSq9snyLaZBgrRSMttqwqWYgAIFB0EQ/tOK3psAd0QfUhj93MFZHcGzgYNv5IuKXMZn+IZLKblF+e0qHSh8N9AAXogZ5Kov+Q7V/j7BQJR7k9+ftACk8MyLqIBO24+0S/bs13LI54rKer2gVXX3nufCOIdOzvRqq5hhc/SBD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AKYJcttA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so1956432a12.0
        for <linux-edac@vger.kernel.org>; Thu, 21 Aug 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755795533; x=1756400333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
        b=AKYJcttA/ghZKZYC7tZBkFM0Mb2/EgCjLiCsho3sVE1N0zQlOUuY23ZAdao0V3gQN+
         9bsm8X7d/L0hK6WIDN6Q7JT4qGdMAlNSbC4PrBkk2o//JNflnpbNE6uLpwPORZZJ2WkY
         sZfonTzb7tqKst2ugQrihXHJpDuRGh4bCcGSQ5OvKyLOP0Puz+TmiUU+SESdROqDEE74
         4skQxgs8BJJ/VyO/18R4Hk/Kzc3XXQHtbY6g2AZQmSihSYNMOv6iUPm2j4vWbD29Fh2z
         5bVC0iFxZZYfQAUlio6uwk99op7mmkdITWEJGzXYeLAHqYLk3dY0emEHOQaL3xzXyAXM
         FcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795533; x=1756400333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A4U0mFlnkILhub4vGFum/rHOWkZrlTYW603OLEkJVY=;
        b=O+1a5icYBVCjlGJ83KIlIww0mQwhlOACVK3mMNB+p4G4wSMXh0tQCUDdNliV2i39wv
         wIbKVpMquqTjXKvcOJe+8xDGNQgL2WV+qF3mgA3w3XvkmD0aTCKyhCbs1LZS/YTb7xrB
         6KfQWaQtfNU4HF7gvaKkZThYUyAiKiqQ9cXrc3s3h12DFFriUV+eGpW49WFeW1tUP4pf
         5iFhuefohpJBIHrs6VAAVY7BA8fQO5iNfsmZGHQqU8hAX26Obj5KMORPJ7aFhTRw6vhG
         fLMZGpSi5BekWGBP526ihWVpKWXWekJK/AkI4lGLSd15mmVa9JP4VSzF+j16gfdHd0Ri
         waTw==
X-Forwarded-Encrypted: i=1; AJvYcCU4pPLCWD1oP+yYrqUWzw/ABGvR9ZXPnvp+o3jWi9zRhG0+6MTLUsQiuRrUE2dzJCJFG2GBveF6QrUG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TyM80aRsw9ArCCM1kHmn0PUKFNeLkBdr8tnutdSgvzOhLk/S
	LGf8g+sjnuP8TXVY23D65Ol9qMjXb06bwpS7ZLfiOMsBhOqRHZROdSTGiG0Ge04wJqc=
X-Gm-Gg: ASbGnctZSmaxQDuE1VGZ0+JpMcTyjiGxk8x41eIZd0vC1kPyvy5wo9iPi3FrsHWQ74O
	nb6BGXHw5dtdh7KShzDNlCZsRt839M34I1xXceVkhzyHYX+TjKJvlAUoxTyoIynCVYP5ITbcYtF
	EjpdxfF930vmzeKInf448tpwx5aFBHLnIF33AMx9Oj9YVOVizi+77jOVGj5jU21BdmCtHL60Y5J
	/AHcOgHEeswI/jpSAGPelEmsCfDU60jUtunJkHlDHk/6dkHeDa90OHppI4+Hsi4wLwTmfPbRKEK
	PzkL2dcMwQ4gDSE2ochWPRCfpmYUf+qhxiIA8zdxvVvjdQv8mXljyuvHf+9WjhNgBaX5DZcStao
	daJqxnQdDN25HotKy+8FVacWFtb6AFZqEWWM4OGMN9Xn9lqJ1
X-Google-Smtp-Source: AGHT+IHbD3hrlfzfuV9dgz0//kT04PlITNsV9cNrzMXodwD/dQM9X/pgqOr/RoZqgWohk3JzCKOHjg==
X-Received: by 2002:a05:6402:5057:b0:618:6fef:83e9 with SMTP id 4fb4d7f45d1cf-61bf8743d4cmr3099366a12.34.1755795533295;
        Thu, 21 Aug 2025 09:58:53 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61a758ba909sm5450122a12.54.2025.08.21.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:58:51 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: zhenzhong.duan@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	alison.schofield@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	helgaas@kernel.org,
	ira.weiny@intel.com,
	james.morse@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	ashishk@purestorage.com,
	rhan@purestorage.com,
	jrangi@purestorage.com,
	agovindjee@purestorage.com,
	bamstadt@purestorage.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Thu, 21 Aug 2025 10:58:29 -0600
Message-ID: <20250821165829.3471-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <SJ0PR11MB67441DAC71325558C8881EEF92A62@SJ0PR11MB6744.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello. My team had independently started to make a change similar to this
before realizing that someone had already taken a stab at it. It is highly
desirable in my mind to have an improved handling of Advisory Errors in
the upstream kernel. Is there anything we can do to help move this effort
along? Perhaps testing? We have a decent variety of system configurations &
are able to inject various kinds of errors via special devices/commands etc.

Thanks,
-Matt

