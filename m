Return-Path: <linux-edac+bounces-2095-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CB9A07EF
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E350B25DBB
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147F2076B5;
	Wed, 16 Oct 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FCrxX8Yo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B061C07F9;
	Wed, 16 Oct 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076375; cv=none; b=fytCDZvXu6Si/UyDizwyJPfzlVLqLuqyOWCgpfzNh48adgEMFo9TbE6S1H8CHwI76plUnRLCqp3tuvsCeX3tv/ACLX9az3OkboHzKhvo6d1Ucxq4viELZ2NMAynLzLhVMUOt1BDy5KKqbhweg+obJpQFKdau4pIMqS3PY84Oae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076375; c=relaxed/simple;
	bh=z6QRm0J2I++VLMK4orPSe4kHg6UZzQ44XST8c0Wy+aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+DNENOyolJZHdruhpD9ZEbEv0Xg0aleqTjjUTrYN5b4cOzx2ctwdWd1ghrmBXlP+w9asexMFUa1ySa3/BKLnbXoF1RNwgyhaOEkXhR4IzJH22Ksp56jTDB7lhRPaV8iPtjN2bcvGjPaGq8hgQOafoJ9E6/1+RXnRTHxsY+ZSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FCrxX8Yo reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6A8AE40E0198;
	Wed, 16 Oct 2024 10:59:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H-8ABRph_QdB; Wed, 16 Oct 2024 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729076361; bh=zv5a7UXvwk4zGhwGx+Twn4ugNezq5/Up+qwxz+Hta1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCrxX8YoQ/0ZHFOf4iWtfypQOEK/v75QEQqJ4SCZSvzWZ6ndsHmWNi5BSVB3wDZsH
	 ghUpOMJMJU0c7Lk59YRlV8HC+kKwfmzEkLDx9ShZgxBS/wSkiAkc1fo+s0dEL+qgBI
	 Ft6c7lrtmoWtqZyksnii6gHt0u6RrGxL5NfWtyeAk7wHSSFZb1PW1WN3IA0BaYiNSW
	 ppG7DJp6ZCsJ/SJySvir3y4W4nIQJx0+QDMC142tXw8u4WifNm/coXUNYyPWiMEtS2
	 v6geuGqyprz5T3/yD1ymW+QS4/Us0w9DZ6507bTKISm81TyhbMbfwNG5l+sr6BD2sV
	 lNw7XDM7eCV+Ka6zhbJmZFtty7T1DnBZQRJyaqwPP1y4CDOz/5ehRWJ8lMgqH8bGK/
	 5CE8GXtjuoBKQNbJZ9cvpKeAmhGAQoen6Nz38IJQwg0fBjcGKonYfrXUAjPb3SlqIN
	 sPCcYWGsvpU03dWQTW0PtcWJkez3oCQ0m5UlwrDqvhzM48ikXuUQpmlrxQwDztE5P8
	 tfrGwtyJiAT7QUSbX0HXPJxj7hqg5WmPQ/8lvYOJKm61S2P1zmF7CPPZXzvyOO11/m
	 GFCt+qosgfObsqGmYBn/tX69pJ5KGO+z3b42BcfTb6kgmY/M5vz5sMO6N5Ga/Pw1ZY
	 QbIE8Eew44X1U944NxCePlIs=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D10C40E021A;
	Wed, 16 Oct 2024 10:58:38 +0000 (UTC)
Date: Wed, 16 Oct 2024 12:58:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v13 01/18] EDAC: Add support for EDAC device features
 control
Message-ID: <20241016105832.GSZw-cWDOFweQMWRgZ@fat_crate.local>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
 <20241009124120.1124-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009124120.1124-2-shiju.jose@huawei.com>
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 01:41:02PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>=20
> Add generic EDAC device features control supports registering
> RAS features supported in the system. Driver exposes features
> control attributes to userspace in
> /sys/bus/edac/devices/<dev-name>/<ras-feature>/

Chatgpt prompt:

| Please check the grammar in this English text: "Add generic EDAC device
| features control supports registering RAS features supported in the sys=
tem.
| Driver exposes features control attributes to userspace in
| /sys/bus/edac/devices/<dev-name>/<ras-"feature>/

Response:

| Here=E2=80=99s a corrected version of the text:
|=20
| "Add generic EDAC device feature control support for registering RAS fe=
atures
| supported in the system. The driver exposes feature control attributes =
to
| userspace in /sys/bus/edac/devices/<dev-name>/<ras-feature>/."
|=20
| Changes made:
|=20
| * "features control" was changed to "feature control" for consistency a=
nd
| clarity.
|=20
| * "supports registering" was changed to "support for registering" to ma=
tch the
| structure of the sentence.
|=20
| * Added "The" at the beginning of the second sentence for better flow.
|=20
| * Corrected the syntax around the file path to ensure clarity and prope=
r
| * punctuation.

Please run all your commit text through some LLM AI as they're apparently=
 good
enough now to help me in correcting grammar.
=20
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/edac_device.c | 105 +++++++++++++++++++++++++++++++++++++
>  include/linux/edac.h       |  32 +++++++++++
>  2 files changed, 137 insertions(+)
>=20
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 621dc2a5d034..0b8aa8150239 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -570,3 +570,108 @@ void edac_device_handle_ue_count(struct edac_devi=
ce_ctl_info *edac_dev,
>  		      block ? block->name : "N/A", count, msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
> +
> +/* EDAC device feature */
> +static void edac_dev_release(struct device *dev)
> +{
> +	struct edac_dev_feat_ctx *ctx =3D container_of(dev, struct edac_dev_f=
eat_ctx, dev);
> +
> +	kfree(ctx->dev.groups);
> +	kfree(ctx);
> +}
> +
> +const struct device_type edac_dev_type =3D {
> +	.name =3D "edac_dev",
> +	.release =3D edac_dev_release,
> +};
> +
> +static void edac_dev_unreg(void *data)
> +{
> +	device_unregister(data);
> +}
> +
> +/**
> + * edac_dev_register - register device for RAS features with EDAC
> + * @parent: client device.

If this is a client device, why is the variable called "parent" and not
"client"?

I.e.,

	struct device *client;

For clarity and simplicity.

Or call it "parent" because you do:

	ctx->dev.parent =3D parent;

and forget "client" altogether.

> + * @name: client device's name.
> + * @private: parent driver's data to store in the context if any.
> + * @num_features: number of RAS features to register.
> + * @ras_features: list of RAS features to register.
> + *
> + * Return:
> + *  * %0       - Success.
> + *  * %-EINVAL - Invalid parameters passed.
> + *  * %-ENOMEM - Dynamic memory allocation failed.
> + *
> + * The new edac_dev_feat_ctx would be freed automatically.

Why is this important to call out here?

It is a common coding pattern of freeing resources in the release functio=
n...

> + */
> +int edac_dev_register(struct device *parent, char *name,
> +		      void *private, int num_features,
> +		      const struct edac_dev_feature *ras_features)
> +{
> +	const struct attribute_group **ras_attr_groups;
> +	struct edac_dev_feat_ctx *ctx;
> +	int attr_gcnt =3D 0;
> +	int ret, feat;
> +
> +	if (!parent || !name || !num_features || !ras_features)
> +		return -EINVAL;
> +
> +	/* Double parse to make space for attributes */
> +	for (feat =3D 0; feat < num_features; feat++) {
> +		switch (ras_features[feat].ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->dev.parent =3D parent;
> +	ctx->private =3D private;
> +
> +	ras_attr_groups =3D kcalloc(attr_gcnt + 1, sizeof(*ras_attr_groups), =
GFP_KERNEL);
> +	if (!ras_attr_groups) {
> +		ret =3D -ENOMEM;
> +		goto ctx_free;
> +	}
> +
> +	attr_gcnt =3D 0;
> +	for (feat =3D 0; feat < num_features; feat++, ras_features++) {
> +		switch (ras_features->ft_type) {
> +		/* Add feature specific code */
> +		default:
> +			ret =3D -EINVAL;
> +			goto groups_free;
> +		}
> +	}
> +
> +	ras_attr_groups[attr_gcnt] =3D NULL;
> +	ctx->dev.bus =3D edac_get_sysfs_subsys();
> +	ctx->dev.type =3D &edac_dev_type;
> +	ctx->dev.groups =3D ras_attr_groups;
> +	dev_set_drvdata(&ctx->dev, ctx);
> +
> +	ret =3D dev_set_name(&ctx->dev, name);
> +	if (ret)
> +		goto groups_free;
> +
> +	ret =3D device_register(&ctx->dev);
> +	if (ret) {
> +		put_device(&ctx->dev);
> +		goto groups_free;
> +		return ret;
		^^^^^^^^^^

Come again?!

There's code after a "goto"?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

