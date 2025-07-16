Return-Path: <linux-edac+bounces-4369-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2AB07859
	for <lists+linux-edac@lfdr.de>; Wed, 16 Jul 2025 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CCE3AE3FF
	for <lists+linux-edac@lfdr.de>; Wed, 16 Jul 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58F262FE4;
	Wed, 16 Jul 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5hdh3nU"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E5262FD8;
	Wed, 16 Jul 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676945; cv=none; b=ikCfy1d8TuWROhJUQ1zuSh38z4L6U4PahfXl6r0uOfvjqqPknT0zInGJwXnTlFH3Z+HmFxKpQrKiYJ5nE/L1yY+5qsHeGbsy5Pwm0ffTNTpf9pbK/nBRBWNaGTc9tCJ5fs0aR6OewNGe1rEh0ajAQLqJSAJZS/9IFrC1FB8llGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676945; c=relaxed/simple;
	bh=0/ykmWj1NAESuF8csKWErzWHYRAWgml7vr6gVvsbGtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMEeb+UCnN2fFPjPO0wfYSHpmsqaiWTJ7ekr9JPCOEp7Cy7nwUGe1HSZ2ItC5AiHuZKdFH2EnyoA8eyd5L4GhlwPWyAnPRB010mT4+UH6nmdBMjzJPDYVBv9mov9gP9Wcgfk2ujpHZvNbhZTTTvfWCoL5aZzXH94+SAfK7phNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5hdh3nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98312C4CEFB;
	Wed, 16 Jul 2025 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676945;
	bh=0/ykmWj1NAESuF8csKWErzWHYRAWgml7vr6gVvsbGtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g5hdh3nUncqoUPE+YK96UKA22b8PagJAoHsiHAx3tKc8y5t2vdR2LJJ2q+23aQ/Pn
	 rhjLRX1XLcZausQtYxJxV6nosyFSiUFvDBmi6NL5XijUszsTxj44VunISwlSjQqvnt
	 7QRsjJrU7+jcnE2n9pszKGZbJB7WRc5PdyQ2QcWAlU17k6OtMVlotSB9XHWDco/wRs
	 fOgxLRxHCnqRLLZlvLHsN/aplfIrZBebCv47MZW23WHwT1IdTFMoqn7/h2LpVCeOVc
	 ey4SAIbfy0+/pjx+ltHugaaIwR3KNp1urJf0yOhmPREbVwj50k6i/VzCdmiWISX3YS
	 d5JCPtZDt14zQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41baecbdd33so121b6e.1;
        Wed, 16 Jul 2025 07:42:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVKdJfqS+pjeTGLgkZZLfgdHNr/TrOZPNjIEqfVse6IWBikGsW5WtRa46jHAcTdeQEgVfcsy+LI6Mx@vger.kernel.org, AJvYcCVdjfyLkjm9BmQn4ZCdyQSfQEF9A38PfFp3Hthu/mtXtCmjVRxjwg4fqroBWlaCaRkJMuoaKhCDsVG1@vger.kernel.org, AJvYcCWPTeCGISpy44wl5Hg30k7al/4aOlGdnbrNVbWMnh05hO4BGTRIyGFEXL5PouFe+X99TFuX1iX8j2Xgjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLr5poD4WFkVsNSgEnYD9Z7xgv60Xv4JaRzWgCz8/upRZ+9CU
	GGRL3eF+Vuod0jOGclrT8iBV1W48XvHuPDAgVFfMBpRklz0cd4fbEebk975fGncIaX2JcD1Ln97
	yCbfJhJ7QyU+4yUcBFOd+LfhTxMvBoF0=
X-Google-Smtp-Source: AGHT+IGqH01WaTHZKIeu9u+hxM8r8VKU0j5xErHnQt7fo8qqxlNE87snX0L+Bksk3cY2EvTLzQWMO8cUAdGYYdtAokQ=
X-Received: by 2002:a05:6808:1789:b0:41c:4ea9:f293 with SMTP id
 5614622812f47-41d031f1351mr2204788b6e.2.1752676944730; Wed, 16 Jul 2025
 07:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617161417.1681-1-shiju.jose@huawei.com> <20250716152818.00006759@huawei.com>
In-Reply-To: <20250716152818.00006759@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 16:42:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqFOssbnsgcc9c6HASc9FRvth804SJ8oSb5aUKZDu9hQ@mail.gmail.com>
X-Gm-Features: Ac12FXxxOONRpDkb3up9ebCJ9NQczS2vVIePuAsvxyi1hrUAGaNzPb2RR3BI95s
Message-ID: <CAJZ5v0hqFOssbnsgcc9c6HASc9FRvth804SJ8oSb5aUKZDu9hQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] ACPI: Add support for ACPI RAS2 feature table
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: shiju.jose@huawei.com, rafael@kernel.org, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de, 
	tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com, 
	Yazen.Ghannam@amd.com, mchehab@kernel.org, linux-mm@kvack.org, 
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com, 
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, 
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com, 
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
	gthelen@google.com, wschwartz@amperecomputing.com, 
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com, 
	nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:28=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 17 Jun 2025 17:14:14 +0100
> <shiju.jose@huawei.com> wrote:
>
> > From: Shiju Jose <shiju.jose@huawei.com>
> >
> > Add support for ACPI RAS2 feature table (RAS2) defined in the
> > ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> > scrubbing feature.
>
> Hi Rafael,
>
> Anything remaining that you are look for wrt to this series?
> Back in v5 Borislav agreed with suggestion that this series should
> go through the ACPI tree.
>
> https://lore.kernel.org/all/3A6C3FC9-B347-4FA9-BA88-3DAF423853C5@alien8.d=
e/

So what's missing is his ACK on this series.

Thanks!

