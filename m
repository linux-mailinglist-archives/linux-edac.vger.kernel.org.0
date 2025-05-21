Return-Path: <linux-edac+bounces-3968-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D38ABE872
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 02:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0821B3B2142
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588223A9;
	Wed, 21 May 2025 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXQToYPH"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CA847B;
	Wed, 21 May 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786042; cv=none; b=SC6CF8L9MK1hIg5Q+19VxCi+x7VXKhFMnSKAyCX02rGD+ghWYfWqhPzFuxZOrR2KuX3xMxtQ1OEwBuyj0JDrQcxo6c69TSCb9vPYqKwyQApnFCNanvDVQ/0r9ZPD8bktUkWvrjb5MYVUWzOjoE4f5eE78ovl4/PmL/8dpoZT7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786042; c=relaxed/simple;
	bh=nuI7nCD6s2QZI/lx6bCkb3rF7h0cqcyUh/uMkCCXYb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEBvgU0BYWzzeP6RlAmQ+66KZ4usbkxI9ki2KuMRGJdL9i/gd+plSFJlBu3Nl3uFwFACdADUTeS9zje2721P4cZHHn5j1LoJP+PGIwNW79n1XL+2skjH4MXdMVHxhIgfc6frOPQAACnoOU8HTmJthcNWNBaXT2Q+/tOWLKeTjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXQToYPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5704DC4CEE9;
	Wed, 21 May 2025 00:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747786041;
	bh=nuI7nCD6s2QZI/lx6bCkb3rF7h0cqcyUh/uMkCCXYb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VXQToYPH4zx2TsuyCUWvmyqrWHPSMvF6sEgqIkhjCjybiQuXVC8OEFmFIJbGEkgsN
	 rJrTYE4j/PFPzKwR7U3Uorp3Rw/HE78eijoCEsa/ttOZ8eB1FQX6nksdDIQHcf5O0W
	 LZ6et52qp88wmrjvLJixpRmGxkPm0etyYrgk4OP8RL32WitCeaTCQ7GeqedTDu9CsF
	 x7ECnbRVyN8iDl/5IiAVZqwwKpYyjLai3ZkTlS2CWa7QSnu8CIpNuQCMX0JGUPIXHL
	 +wrFZUkN/ercQqRVaFD0SijyeDd7cCWbBTD6D8MS0JEQ+GpL9w2UoV9CQQSKP6TEy5
	 CxQezEZWtDWVg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-600210e4219so9516620a12.0;
        Tue, 20 May 2025 17:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoDMuLNZmxEWFDVfdFrHQeQWIGWMYBCZ/njtH/N4pPqUJB+g0pvBcrgBXl8BdJ0SOjpwmxQGtQEucP6Q==@vger.kernel.org, AJvYcCXGbXKUsg+hNGZaFOa58HM91X7DbrZPnt3kIbp/3Dt/HcpaGS3geJqbNcZtHqVNGC7Ztn+b1ua9p6pmee83@vger.kernel.org, AJvYcCXd7NhSCUiYOvkLvUba0IAIONJQ8XqMHdl4hGDP3pxmQ3xpROAjS+4yENt8TgUc8JrjTihLiI5W7aX1@vger.kernel.org
X-Gm-Message-State: AOJu0YxzE/na0q7/JbONfteqfC6160sY3Lrp4DDJYtgsgKmxrdP8k2WP
	Jv0cyxQx2halXYlWEfIl0q1FCL5J90aQ7bu6wDAI/HYpSTbrnzJ3LL5Bl5SvL9xHnNWXVnYwe3X
	E30ltMPlvQ08FkJhlf41mWfix4BW/UA==
X-Google-Smtp-Source: AGHT+IHFvYJlKA4oO/f0c0L0Jj1Dy/t64PAkHGKF1Am7+zYsk7n1Sfn20y2q2iD6Fraf8txCJgHFb8ycHrTHuh6vtvk=
X-Received: by 2002:a17:907:960a:b0:ad3:e742:69ea with SMTP id
 a640c23a62f3a-ad52f86c635mr1490088866b.14.1747786039972; Tue, 20 May 2025
 17:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-3-git-send-email-vijayb@linux.microsoft.com> <20250519090253.GGaCrzvRFC75JnFN1S@fat_crate.local>
In-Reply-To: <20250519090253.GGaCrzvRFC75JnFN1S@fat_crate.local>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 May 2025 19:07:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+T=ARcSe9NByMyiFDN9pns=0f2c=hFEK=o6668MARz8g@mail.gmail.com>
X-Gm-Features: AX0GCFtlnvI1PQSuyNa0d7YyMKxiKCpdtjlyJKhL_scKQa0BWfpEF_tveD7Gea4
Message-ID: <CAL_Jsq+T=ARcSe9NByMyiFDN9pns=0f2c=hFEK=o6668MARz8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: cpus: Add edac-enabled property
To: Borislav Petkov <bp@alien8.de>, Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, James Morse <james.morse@arm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>, 
	Marc Zyngier <maz@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 4:03=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, May 15, 2025 at 05:06:12PM -0700, Vijay Balakrishna wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > Some ARM Cortex CPUs including A72 have Error Detection And
> > Correction (EDAC) support on their L1 and L2 caches. This is implemente=
d
> > in implementation defined registers, so usage of this functionality is
> > not safe in virtualized environments or when EL3 already uses these
> > registers. This patch adds a edac-enabled flag which can be explicitly
> > set when EDAC can be used.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > [vijayb: Limit A72 in the commit message]
> > Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> This needs an Ack from DT maintainers.

That will happen when my review comments are implemented. Those were
on v1. Not this v1, but the prior v1. Version your patches correctly
please.

Rob

