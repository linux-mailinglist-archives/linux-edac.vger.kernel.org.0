Return-Path: <linux-edac+bounces-2410-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630639BA091
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 14:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B8C1C20AFE
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B1198827;
	Sat,  2 Nov 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXiZnWe5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C11922D6
	for <linux-edac@vger.kernel.org>; Sat,  2 Nov 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554512; cv=none; b=grCKi5z9zvoXnVoPNl8zU8u4lz0iRHJhtHQ0EBYjYAy9s3UMB97rn8K+hBAjRv9l5nTdzdXKRMKlQM0Gfx6UrPargMDsS82ZsjgINHYZs6mRVvLun3SdEEsZ2L7nrUpcAY5uxE2R8IFsyxz45lWzHkzQO4895ZkKH5+8zZZFsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554512; c=relaxed/simple;
	bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=Vi6loeJ5tUKBbJWllIvLnnFXnRb7pjvk0ma83Or5MiT/qTy+vKnJnJYhogYiGpL7EM+dPriqTKm0wzcAPsHYZZHoErkv966o21dF3hAZH9jK0G+fkhlu0qmByAJDeUkml6xpiVMpby+0Fy9/pYmbZPJPNxYOrC9W3sKw5It3eYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXiZnWe5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9932aa108cso437547966b.2
        for <linux-edac@vger.kernel.org>; Sat, 02 Nov 2024 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730554509; x=1731159309; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=hXiZnWe5tmqbX4lgZxIhUYxIwZwqZGzNyz/8bGc6WF8uAcL/j749P+LnhvxRurLpJE
         khggXnKR6toWm0+6ErBtkR2NdjhW6tAmjmp67V7RGX521XEek4c8dDfVv1jBnpS7c155
         ML4FFJVcsBueV28eezVQXLxuYCY2Ap6sKDaWFbAaRBkCJ+dQfziE4ORUjQEFQQunzWm6
         Uk7pJ+feuROjpoJP6URE0WOe9pPIied2NhidHOhDPl4FE+w/28ZS+mTlLu4ap/FtiioW
         gBi2CcbDeA/K3LLmOPzp8cH99RQYQQ2c25KBAfRNGw3V0DLGlmvIvwDpfLsq+SFChtQs
         0FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730554509; x=1731159309;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIqagV1NwTECAGQHhrIvxosUcV32d/Vxh+4ati1x+Gg=;
        b=Nq9xpc3e50XiKxnR5T0GWnGvXQGFjm1YuPa4PucoUX8misAsN1z4r68sfB5O56VJvC
         DmkljWD/lfxnZqOSlmma7fsEQT347x/EPSqh8kBUa5olMm/ct/Fe7Zrv8ypspiNN/cxx
         Fn1Ju2C5V2UVdBAsE/f1vo79BaxlDHnHBfS2ElGmFnrH6rfPO84Y9rgSytPAKJG+q/jr
         IU3/+i4HJHkxRpjROimSd03oQuk5KiqD7BYps3i9O3F748AgxKbA/1CwRUEOwQ3Te2ii
         1q57HtwYaDSeA72yXkYWVdk2A+lsE8LKji8VGXdO2KwF4Ntx4Rp6rIQpTTEDChYzUHw7
         zIBQ==
X-Gm-Message-State: AOJu0Yw4dILJPt/sGDUQj4Z8gTQwGysqhwXhh/7hM0g9w9dcPsluCxXX
	hDp8B8z5Z75QLcnx9lNwwmnLx/VjAjj8VT9X8XjY7CXD7VR7G2BQaTwnWQ==
X-Google-Smtp-Source: AGHT+IErAMH/jImMjaZNYbFht2OkCX8sVXp+PXW5yywxlYNfnU9hkOLbJmTDo2B2XilA29imSJF2Kw==
X-Received: by 2002:a17:907:3e82:b0:a9a:6bc2:c0a3 with SMTP id a640c23a62f3a-a9e508ac369mr878687266b.7.1730554508618;
        Sat, 02 Nov 2024 06:35:08 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c53d6sm310170966b.68.2024.11.02.06.35.07
        for <linux-edac@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:35:07 -0700 (PDT)
From: William Cheung <meamithila8@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <10d6bcbfec111bae013db5dab6a516210010904aef9402dc0ddeb4557373b1b1@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-edac@vger.kernel.org
Subject: Proposal for you!
Date: Sat, 02 Nov 2024 06:40:54 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I have a lucratuve proposal for you, reply for more info.

Thank you,
William Cheung

