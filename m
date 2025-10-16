Return-Path: <linux-edac+bounces-5064-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA8BE4974
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74C0A4E38C2
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60A329C44;
	Thu, 16 Oct 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMZwoq7W"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577661AC44D
	for <linux-edac@vger.kernel.org>; Thu, 16 Oct 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632173; cv=none; b=WCq2OjHfvvH3gTV/D7Bf2vHxO3aF5t6pxfMYqI0QZH8cLcJTCFVVYa2wmVMHSL5iert/jnxvkdXPBCI5XE057luAZGjvjHlkLFpOTkUD8QeE7Nx+fqj90QIbGP8QDnj8wlFbaiHcuPPECmnntT8Lj80CZeXJTuZuIVg6M3lqqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632173; c=relaxed/simple;
	bh=V5iXdZUTWXmbmXUTCkXFNu1fakwvvp8GZryPhQdiRhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqPAnyLy8Dt6MOh6lBTFQGaIAXGHaYmc0LO1tDNmSu7O+oL1VghjD848Xm80EWIOVe9pnPuMUoBVYFgiJIz7ZKvqhcJqt2786Lw0aNJ6N+Uat5I4hNQlXxFsCKGPzeNmhcsglROACTzB5XoqboQRwom5xqoJgGsjWUT+gmbr29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMZwoq7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079A7C4CEFE
	for <linux-edac@vger.kernel.org>; Thu, 16 Oct 2025 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760632173;
	bh=V5iXdZUTWXmbmXUTCkXFNu1fakwvvp8GZryPhQdiRhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rMZwoq7WCpLwbZitk/OHHEvNtDunUjkgxEtOc0oakYT+jsmpvZ0GnO36PATRk2Gz0
	 aRjcD7JmMTelqpKPKJ80T+NNL+lCjyNVG6bw/bBaCvSCDZLq0wPBqli38N9QwZ5j2Q
	 qatd1FbNTXwB0z45dKy18B8EFPpRT8lBuIug2Ka9HoHPe3AngUDfp+JCNJ4RliWZkT
	 V8eXJOQQPz5L0+VsoaRG0PjyeraPDwR7O68Qo73912VhPxfmpc+5Zc39z1WzI7+/Xu
	 mxIIRVvM+VMLERDyKatXddOKs8ZJMcR9XA460PYRlmwnXu5MTwHddARtqJJ0xo98NG
	 dzi7Fy6NhR+gg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-441bc60f35bso290823b6e.2
        for <linux-edac@vger.kernel.org>; Thu, 16 Oct 2025 09:29:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk26Mo2M0wGQtke1csIeIpz/SMlyFR98dV9XY1RUTyAgR+5z0+u5Mx7DcQaj/NgndsDFpVGMaF+ilq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9a80mBuw0OP+69yVye8hcu7Bg3nIa4IF3xBLdkKPdI60Z2Yf
	R2SBSnEmdfE2US4QuqWhZ9hUMPU9va3mgu4Ig8tPKk5w+k758FwS6MqG5lrrKZjTu6Awrh32RzB
	lYo7T2o5Milqt8cV8ZFdNy8DazudCzks=
X-Google-Smtp-Source: AGHT+IE/Zx3ePN0Zu+KDX6q0J4Ts+nu/qyRQG/zSt/wER3dCTv1zJE9tGeVTvWMw4i3r8vMWIDZD8Oj6GM0Ejgy1FHk=
X-Received: by 2002:a05:6808:2205:b0:43d:3be9:b261 with SMTP id
 5614622812f47-443a2e71975mr325182b6e.13.1760632172323; Thu, 16 Oct 2025
 09:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-1-4a62967fb2b0@amd.com> <20251016160149.GBaPEW7ej4qvOcVfYh@fat_crate.local>
 <CAJZ5v0gvn21FeMNpJDWOZ0ZH5CZzDt0zEuXjHEpWxHjq9vHqyw@mail.gmail.com> <20251016161710.GCaPEahlw4qsCMaw4n@fat_crate.local>
In-Reply-To: <20251016161710.GCaPEahlw4qsCMaw4n@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 18:29:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvoSUpT3Q5DN3sWZnCOuctSTqn8tOTrboiTgurnF8_ug@mail.gmail.com>
X-Gm-Features: AS18NWDaDD9L1SosPOS4VE_zrdb4v89WWiQPLHH3aiLBNB95jL2jjkani0MnbX8
Message-ID: <CAJZ5v0hvoSUpT3Q5DN3sWZnCOuctSTqn8tOTrboiTgurnF8_ug@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: PRM: Add acpi_prm_handler_available()
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Avadhut Naik <avadhut.naik@amd.com>, John Allen <john.allen@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:17=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Oct 16, 2025 at 06:09:12PM +0200, Rafael J. Wysocki wrote:
> > > Rafael?
> >
> > I've seen it.  Are you asking for anything in particular?
>
> LOL.
>
> ACK/NAK?
>
> If former, should I carry it through tip?

Please feel free to take it with

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

