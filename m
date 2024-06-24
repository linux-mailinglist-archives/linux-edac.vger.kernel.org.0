Return-Path: <linux-edac+bounces-1353-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07045914F13
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B408B203D6
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686413C3C4;
	Mon, 24 Jun 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4zki6gZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3A1E534
	for <linux-edac@vger.kernel.org>; Mon, 24 Jun 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236874; cv=none; b=OvEuNw8qr5dWdgjhzNlERn7nwnQzhJguqHcbqs7wec91T//fiJ3KhTIYeqAV+ibD0yLvMHHKZPJ0C46WDAzzOAPJgtMnWQDtq+vpwk4gQGCutJbN4THnu0uwViwhTtjqN3fvaUKxWIsk6ZRIpKBwMXfWwJZJW/EQJzieH3y6Gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236874; c=relaxed/simple;
	bh=sAPtI0atbmJLZ4d20ykArojCHspivOAYzoxOkx1z0Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gioY8y51P821vzN8QB9BRDRzF6HbZO8SF8et021emqPeTIP0NQIv9D2MCaguWTq0QXiqMtMYdZesNZ8A1x7PiSyMYaLwn0/laQg1PqfCePb6Hrtm2cKeOQrJc33imLZgoHbAFkrvoNTPZYEgKAeFiH1X9oV77YcWNXgOllqWUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4zki6gZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd628f21cso3353125e87.3
        for <linux-edac@vger.kernel.org>; Mon, 24 Jun 2024 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719236870; x=1719841670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0s3LydvkurpzHPSmFqn8SsqqOKpHZfLVy0YgIg6YuhM=;
        b=v4zki6gZMdk2AW5NgDsfuQRa8LkckLPBi+SbfZ7UcucnQ0+/Bqgx7e7CXZtiuoP6F7
         exRadIT9YHshwI8iZSa17ukFShzlwFXr37nhlNLWoczv96eboBZcHkGsiIEvFc/tU+eI
         DBKeHz28fr7hyD60kVciIno3M79lXrUneQK6EdJbpTf5MJsJ/RzzlC8z7bbKGOuH7bPp
         pgwilACPcTYg4WojavYN677DapNZEdsUQ6Rt+uoSgC+gfxsM6GAw7dkPyr+dvxQNEknk
         9M45hzPglFCKYzyOkXCADdfQA205xL/ITSnpDsAio/2is0sRII2PXcGfEAgTAIIwvwv9
         sybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236870; x=1719841670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s3LydvkurpzHPSmFqn8SsqqOKpHZfLVy0YgIg6YuhM=;
        b=pAy4feCF/3gN95vekBTv20v/CTHgvlIF9ZHfqr4ZA57yU/NvSaS0IN4I/22b3fR8z/
         WQ/MkVfkJHHcxvbs2nQpOxROaGuEF6vJlhMyNz6A3iuhWMK21t+zl+Sc7T+09DH0gtsB
         q7IUleQS5Xw9pmYA0u3MhE80viBqnTWLCtFGDybS954g4HnzeeRmI4DF6gEEaG4WY8Wi
         a2LeKcJchePYk8rwjth/RnyQcvmGFvZ5a8pbxu9Oet/pWMqeEEEcpAnCZflIArGGoHzp
         CdAcHJafo2ox08FXdZLxoHFhZ7qyY8w0VxXVsu2gecJAujh+YtNN6lB86r1ubPXlHJIV
         T/uw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8jEJkNzZHsYRUyHTpyMSnFr97/Dr/ksMIcGjGF4R2gu6mDrm2sHSIvKFY+QchIV+8xmJ5Fv+YhwfAdpLnsKe20zUhk28KvVR0w==
X-Gm-Message-State: AOJu0YwLMr1GCjDNdOhbqZ/xsxYSaTRPcYuIefk60hGaEkVU7JkPkjzL
	/xAhk01Xc2kyYbbDFafJ9dGcsR2uvfsTUh/nfAcDOIjyibnaKRD4Jyejnsb6c7IwDJRGpJtn8+7
	Q2OIq9qVyL3NON3+4mgXqE1/2Iig4CbYuNo8ghA==
X-Google-Smtp-Source: AGHT+IEak+AlU/sGyNgKu71+/v2DuvHcCZWwEj3MVCEKEJeB0lgx0APIFcwedpxjChNmBHua5VVMWIwXUZl45G8fzec=
X-Received: by 2002:ac2:550d:0:b0:52c:e126:3d50 with SMTP id
 2adb3069b0e04-52ce183bf44mr2481283e87.36.1719236870433; Mon, 24 Jun 2024
 06:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621165115.336-1-shiju.jose@huawei.com>
In-Reply-To: <20240621165115.336-1-shiju.jose@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 14:47:38 +0100
Message-ID: <CAFEAcA9CQ_D168MmD+VbQsegUVsJuiXBP64oH0SgL=bD8EDJOA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-edac@vger.kernel.org, 
	jonathan.cameron@huawei.com, mchehab+huawei@kernel.org, tanxiaofei@huawei.com, 
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 17:52, shiju.jose--- via <qemu-devel@nongnu.org> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>



> diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
> new file mode 100644
> index 0000000000..953a9d6705
> --- /dev/null
> +++ b/hw/arm/arm_error_inject.c
> @@ -0,0 +1,49 @@
> +/*
> + * CXL Type 3 (memory expander) device

This doesn't seem to match what the file actually does.

> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-v2-only

Why are these new files GPL-v2-only? Our general preference
(see the LICENSE) file is for GPL-v2-or-any-later-version.

I also notice that this file is marked as copyright Intel, but
you're submitting from a Huawei email address.  What's the history
of this code?

> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qapi-commands-arm-error-inject.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/pmem.h"
> +#include "qemu/range.h"
> +#include "qemu/rcu.h"
> +#include "qemu/guest-random.h"
> +#include "sysemu/hostmem.h"
> +#include "sysemu/numa.h"
> +#include "hw/boards.h"
> +#include "hw/acpi/ghes.h"

Looking at the code here I'm pretty sure you don't need
anywhere near all of these include lines.

> +
> +#define DWORD_BYTE 4

This seems to be unused.

thanks
-- PMM

