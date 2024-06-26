Return-Path: <linux-edac+bounces-1390-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42291983B
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 21:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A38B20E9F
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A218E77D;
	Wed, 26 Jun 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjeTZwRI"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF4149C57;
	Wed, 26 Jun 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429722; cv=none; b=u/SDxH7QUzr3QND9+N7dtYXRb9l+Bgjqr+18cLtsuYWDt1HDwfzpsOf/GvEK9rvwIPtGozcR9zhOaDbGdwrd5izoWIpywhN/pW0EsIdP+sYAIz+YzyiqjuVJd67YbNyg2Db1KsKc3TyieL9M4eEq0RwedR21iYy1L1c7AK1BsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429722; c=relaxed/simple;
	bh=4WnZ0l3DeZvq30YzaS4Z/gz6oAgjUOpHqb4F/BV0CQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep24ZJVK0rCKwwJeA0YhAIm7UipeARn3pF32B+CAUwCNx2kB3H8/KmDspFhMCsKyCT4B1cxGoalC+PSInvS7XAEMrlNnQKMBB8u+UFx9NI709GGlR3QTmAUxOn3dD9NE0wIdb6j2meHNNv9ZlZHPFBoeOzMy1Dg5I/8p4OJhJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjeTZwRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFFC32786;
	Wed, 26 Jun 2024 19:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719429722;
	bh=4WnZ0l3DeZvq30YzaS4Z/gz6oAgjUOpHqb4F/BV0CQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FjeTZwRI+9mVPRtOb8hpn7BiukSPBGdb5TEoJMJbT2KG6RFURVKabzQH0uqqUAoKH
	 4M6bNZevqP6NEp7V/X+PHleYkivy1Pgp9U38L6ZbNWkj9sAynyjeGsjJIOiAgRMRKO
	 +R47mVzg8l53SSGenbAPaTruX95kT+m0BvzX0wG/m6jjPq2T9bd5bakB0+ijFXa1c+
	 TmvnCZxuelQvc8ixgc35Cc5nm446wAodp9Rnpg6lWu4X0UfzA+hiY7T5AVCmS8Wj85
	 TwQ5Q1qJJ8cXK1hJJPSHFIZ5ic0FC8HDI9t3SXhpUwtkla4UOlHIfrDGNMCRJxIYjm
	 kHOKEDd/e1Vog==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c7cd2f077fso1216216a91.2;
        Wed, 26 Jun 2024 12:22:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYspKOXsswuimxTyyKQ2Q1xQq5bRhW0WO3K6BJP2JX+/IwWvNHQv4S4DZk42aRHeaU3I0YzzOhjvuhKYAbZRQ9ayKE8nllMhh4TJP7T4qWdAAXiN4gDSCb9KuMAYklkg3QzNG3iDZAyGatKn0DprcjtHGU2S2cPmWkNvTzmCjhK/LVQK0=
X-Gm-Message-State: AOJu0YwZI1SoC1/e+B0RLykJteiedojBxN7zbnRAuvFSyU7Jo9T+xVEZ
	aFnTp2L7mBDGJIwoK9IkZNQHHLCztBehW1l1p5lx/yg0Kj1w/FOIovi4z6h1AY5rR1cL1pQph13
	VmPpJkXsGZJxnLIwXeRVJzPU0GMI=
X-Google-Smtp-Source: AGHT+IGgFTWDoXas0ho3FyG+kykuNjyhR8cjQpC8yo65fGwZM3VFs+LYYXcRVwoAMX2btWTHVAJFCa3kEpFatALGVR8=
X-Received: by 2002:a17:90a:c091:b0:2c2:204d:6c2 with SMTP id
 98e67ed59e1d1-2c845e4d1b8mr11738795a91.2.1719429721552; Wed, 26 Jun 2024
 12:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174721.72018-1-john.allen@amd.com> <20240506174721.72018-2-john.allen@amd.com>
In-Reply-To: <20240506174721.72018-2-john.allen@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Jun 2024 21:21:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAnQvBo0vyCwXC=NysA+HTrMi_45hKBdk+xTy5KUZMMA@mail.gmail.com>
Message-ID: <CAJZ5v0hAnQvBo0vyCwXC=NysA+HTrMi_45hKBdk+xTy5KUZMMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: PRM: Add PRM handler direct call support
To: John Allen <john.allen@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, bp@alien8.de, yazen.ghannam@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 7:48=E2=80=AFPM John Allen <john.allen@amd.com> wrot=
e:
>
> Platform Runtime Mechanism (PRM) handlers can be invoked from either the
> AML interpreter or directly by an OS driver. Implement the direct call
> method.
>
> Export the symbol as this will be used by modules such as the AMD
> Address Translation Library and likely others in the future.
>
> Signed-off-by: John Allen <john.allen@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> v2:
>   - Align statements setting fields in context buffer on '=3D'

I would actually prefer spaces around the "=3D" there, but anyway

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
>  include/linux/prmt.h |  5 +++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index c78453c74ef5..1cfaa5957ac4 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(con=
st guid_t *guid)
>  #define UPDATE_LOCK_ALREADY_HELD       4
>  #define UPDATE_UNLOCK_WITHOUT_LOCK     5
>
> +int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
> +{
> +       struct prm_handler_info *handler =3D find_prm_handler(&handler_gu=
id);
> +       struct prm_module_info *module =3D find_prm_module(&handler_guid)=
;
> +       struct prm_context_buffer context;
> +       efi_status_t status;
> +
> +       if (!module || !handler)
> +               return -ENODEV;
> +
> +       memset(&context, 0, sizeof(context));
> +       ACPI_COPY_NAMESEG(context.signature, "PRMC");
> +       context.identifier         =3D handler->guid;
> +       context.static_data_buffer =3D handler->static_data_buffer_addr;
> +       context.mmio_ranges        =3D module->mmio_info;
> +
> +       status =3D efi_call_acpi_prm_handler(handler->handler_addr,
> +                                          (u64)param_buffer,
> +                                          &context);
> +
> +       return efi_status_to_err(status);
> +}
> +EXPORT_SYMBOL_GPL(acpi_call_prm_handler);
> +
>  /*
>   * This is the PlatformRtMechanism opregion space handler.
>   * @function: indicates the read/write. In fact as the PlatformRtMechani=
sm
> diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> index 24da8364b919..9c094294403f 100644
> --- a/include/linux/prmt.h
> +++ b/include/linux/prmt.h
> @@ -2,6 +2,11 @@
>
>  #ifdef CONFIG_ACPI_PRMT
>  void init_prmt(void);
> +int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
>  #else
>  static inline void init_prmt(void) { }
> +static inline int acpi_call_prm_handler(guid_t handler_guid, void *param=
_buffer)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
> --
> 2.34.1
>

