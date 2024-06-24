Return-Path: <linux-edac+bounces-1356-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFD9152B9
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8AA1F212E7
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D319CD14;
	Mon, 24 Jun 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pphmszRk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD319CD02
	for <linux-edac@vger.kernel.org>; Mon, 24 Jun 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243733; cv=none; b=he/x51RSBRv4IGcXofPdo04sX4ZPWutaVS0lWot8ul95SW3+9qPKvmEmljDli41Iv7569G5InvO5H8hSKUGsf6Q/1NAkf6EGKTjWVxlhHV49ETB7qsiq2dyH0lly0ELg0g9xO0qr4rlhV1pLODIbUUZNCXc33IrspoXNhBGt93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243733; c=relaxed/simple;
	bh=dTpPJuJdKd3oUCFZ0p+ZSqtYmfTe6LBFMemmMY88Fdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuLjGF3vy4uEjKsV5eAi1Ob0R0zo9mFsomtgaGfXLUssWM1SZgYm8ykyM/GNo50BUdIVPPJ9Gto88aGwMrBNYUlXgAbXqoHvSpo2oFsDWJ6WQbVs9w29/YBi2z1pBb4k683Z5lvCDiLnaZDdRzh2ATLSEsJWCtB2J+jCZb02HKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pphmszRk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so4910100a12.3
        for <linux-edac@vger.kernel.org>; Mon, 24 Jun 2024 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719243730; x=1719848530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6ISa8+Qw+F0SnhHbSOOPpnlg7ypL2Jw8gPcbTV6Sto=;
        b=pphmszRkgXPNn8RucBFrA0clxgNPPWGHcc2prF6uhqdIcN9YWtgm0lDZ+QZVx8IOGE
         jV0CP122SyPjX3pPT4MBZySApWLtD8NtSeX5HpSbCJv5UjxL8GuyQTKJ2tVZfMTkZoZB
         nkjtzRt1EXA+L/GsRMWCH2lmkm5IKmoFc8RJqhXFrfFUR2CDiH+tJivaYWw0gEj5i8t9
         fcConTYxQQRRI1GUia/ZYdGNBCZNvuvEMxxKlNdkwrnbo/I/vej/bmP2d7yrgFK84yRP
         8WGCbLouSb0jcAHku4nsWPb7X9B4XFuel5c38Rp0L9t+w0bMFAQ9D7QlWp6Pn9wV5Cd7
         k+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243730; x=1719848530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6ISa8+Qw+F0SnhHbSOOPpnlg7ypL2Jw8gPcbTV6Sto=;
        b=D7nVtZpyvSUFNulUIxL3qT+1ZQ6xwBJH/uF8pHj93E3I97JEMEOriWk19m9FrX6e0f
         XWIKocbo0wcnePBe3VP38VAFF9B78vUc7SFmVs/cS4sKi6jsI5MGC6wyITWq0BNXThzv
         kciMOlglUu3PpZrZJocDkFd8e+wOXjuVE3YAjuTFc0ZPf/7jjNqG85GUue16fJs0Z1tH
         LOF5NdvRCUdTiPvywVzm6rGP/NsxPdmpPoAJZazSl7alWOXetiIoyGOSyMf7x1eaCDiz
         ExuKRl8f2sYyZ+epCKLHkxmXbhboyQ87lvEyXcOc2TnvbI3ilq0vSg9OpqCWVCN6HEx+
         vtTg==
X-Forwarded-Encrypted: i=1; AJvYcCXASntAB3KyjG6eSPVtmiyexVEzN5CfGLK5yMbVUK8rMkkuVoRXM7+A6Ce6TPg8nJaXkq1o+h1EqoGHi+kFbEW1VleltRa2/QKwWQ==
X-Gm-Message-State: AOJu0Yy9bukqhcWm+V4EKYQMYggErUBT0rLKccZB4TdH6vRiDuM1uHSW
	sP9BdoAmxpc8SUMtLaD+KnsfPa6BCZhAoNXNMR7xOTzcY/GBKZudqt6Gy9tB0ppqXCtQDXAXI4F
	q7C2OOLCYAJG4DJYiRVJ2cxn+ACBjy8CeIKCKlg==
X-Google-Smtp-Source: AGHT+IGA+3gMHcvf89knvnrlKHjJS/xJ4+QDVKj+pOyx22HllTyQgeI+TldxkYYhG1jeT/9V8Oy7VxaWoEJDAP0mX8Q=
X-Received: by 2002:a50:ab14:0:b0:57d:2659:9141 with SMTP id
 4fb4d7f45d1cf-57d4bd83465mr2719496a12.24.1719243729977; Mon, 24 Jun 2024
 08:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624153950.350-1-shiju.jose@huawei.com>
In-Reply-To: <20240624153950.350-1-shiju.jose@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 16:41:59 +0100
Message-ID: <CAFEAcA-UR7a9Se0f4W+naLrXrvMCeFNBCVYq=--wROM2igS6eg@mail.gmail.com>
Subject: Re: [QEMU PATCH v2 1/1] hw/arm: FW first ARM processor error injection
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-edac@vger.kernel.org, 
	jonathan.cameron@huawei.com, mchehab+huawei@kernel.org, tanxiaofei@huawei.com, 
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 16:40, <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add support for QEMU based FW first ARM processor error injection.


> +++ b/hw/arm/arm_error_inject_stubs.c
> @@ -0,0 +1,22 @@
> +/*
> + * ARM  Processor errors QMP stubs
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-v2-only

You missed an instance of gpl-v2-only (but you don't need to
respin immediately just for this).

thanks
-- PMM

