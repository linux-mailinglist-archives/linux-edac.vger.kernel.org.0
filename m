Return-Path: <linux-edac+bounces-2902-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA446A10994
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 15:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91901666B0
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FE149C4D;
	Tue, 14 Jan 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS+VSPBL"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBF155725;
	Tue, 14 Jan 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865596; cv=none; b=Z02W6lmSZcukwLLcqPfKGuxFoAB5MOcX/Si/qP/5ZiPr8GcRFTfNxUv6mE4Xsj+sn+mEGrRdNKBijpXONLwnfdQgmVuIuBXRGeXftr8+93PJcYfJ1qi2MfRkTCbuAPxRhgZFvj7dfL3qwTafGgAFHWvfnqAsAg4JdstWBsU8Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865596; c=relaxed/simple;
	bh=ExS2XTnmU7QoqvKEZZKQwlQZG7UBPVImqCL3EVuvJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkqbRpn+F+GidSVrZdVvsPh+fI5GuoMrYSqWE5IrwhjI9n6/QosBFaQ8+XZksEIATXxSQMxWFunYM+9F2jfjWDIoe5rsx2mCLlV/bkxJtab9Io7+TJYuDgfbWPD1J7NInNbSIVntEDm9hf/d/KvYUNCMxJLDSpG68Bio7/wnXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS+VSPBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50007C4CEDD;
	Tue, 14 Jan 2025 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736865595;
	bh=ExS2XTnmU7QoqvKEZZKQwlQZG7UBPVImqCL3EVuvJ1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mS+VSPBLnIh9ocmdfOtRPbEkZcAA4UuraLiRGI8hm4txbPh+o71mExyAniG9VUDps
	 FwTB5Dr2YxS0UVSqkGlo7HDQTKqWa7tezWwUa0oAK3EiTJW63h1+n/gZJk4ECWe6qK
	 WIthCuDPPlnAiRVcZGoelTqQ6KOcwgTwWamhAwXs8xZSWbHuroODvNdGcbokikTLYj
	 5Yi3ezMpvQKpj54cWj9K44AwAgxylCFyUmnoUSYAcoVjRiBF+LExG8olwlOqojMauY
	 4G4Zu5f5Ew5qhSalw5KjAS1Yy7A9HSJSxyfgZFRjprrk0houA1gihZhHxxH5Iys9ic
	 boA/dgQXZ1Ajw==
Date: Tue, 14 Jan 2025 15:39:44 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tony.luck@intel.com"
 <tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
 <mchehab@kernel.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
 <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
 <rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
 <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
 <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
 <duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
 <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250114153944.7b525a04@foz.lan>
In-Reply-To: <20250114130537.0000375b@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250114133817.20048aa4@foz.lan>
	<20250114130537.0000375b@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Tue, 14 Jan 2025 13:05:37 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Tue, 14 Jan 2025 13:38:31 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > Em Thu, 9 Jan 2025 14:24:33 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> >  =20
> > > On Thu, 9 Jan 2025 13:32:22 +0100
> > > Borislav Petkov <bp@alien8.de> wrote:
> > >=20
> > > Hi Boris,
> > >    =20
> > > > On Thu, Jan 09, 2025 at 11:00:43AM +0000, Shiju Jose wrote:     =20
> > > > > The min_ and max_ attributes of the control attributes are added =
 for your
> > > > > feedback on V15 to expose supported ranges of these control attri=
butes to the user,=20
> > > > > in the following links.         =20
> > > >=20
> > > > Sure, but you can make that differently:
> > > >=20
> > > > cat /sys/bus/edac/devices/<dev-name>/mem_repairX/bank
> > > > [x:y]
> > > >=20
> > > > which is the allowed range.     =20
> > >=20
> > > To my thinking that would fail the test of being an intuitive interfa=
ce.
> > > To issue a repair command requires that multiple attributes be config=
ured
> > > before triggering the actual repair.
> > >=20
> > > Think of it as setting the coordinates of the repair in a high dimens=
ional
> > > space.
> > >=20
> > > In the extreme case of fine grained repair (Cacheline), to identify t=
he
> > > relevant subunit of memory (obtained from the error record that we are
> > > basing the decision to repair on) we need to specify all of:
> > >=20
> > > Channel, sub-channel, rank,  bank group, row, column and nibble mask.
> > > For coarser granularity repair only specify a subset of these applies=
 and
> > > only the relevant controls are exposed to userspace.
> > >=20
> > > They are broken out as specific attributes to enable each to be set b=
efore
> > > triggering the action with a write to the repair attribute.
> > >=20
> > > There are several possible alternatives:
> > >=20
> > > Option 1
> > >=20
> > > "A:B:C:D:E:F:G:H:I:J" opaque single write to trigger the repair where
> > > each number is providing one of those coordinates and where a readback
> > > let's us known what each number is.
> > >=20
> > > That single attribute interface is very hard to extend in an intuitiv=
e way.
> > >=20
> > > History tell us more levels will be introduced in the middle, not just
> > > at the finest granularity, making such an interface hard to extend in
> > > a backwards compatible way.
> > >=20
> > > Another alternative of a key value list would make for a nasty sysfs
> > > interface.
> > >=20
> > > Option 2=20
> > > There are sysfs interfaces that use a selection type presentation.
> > >=20
> > > Write: "C", Read: "A, B, [C], D" but that only works well for discret=
e sets
> > > of options and is a pain to parse if read back is necessary.   =20
> >=20
> > Writing it as:
> >=20
> > 	a b [c] d
> >=20
> > or even:
> > 	a, b, [c], d
> >=20
> > doesn't make it hard to be parse on userspace. Adding a comma makes
> > Kernel code a little bigger, as it needs an extra check at the loop
> > to check if the line is empty or not:
> >=20
> > 	if (*tmp !=3D '\0')
> > 		*tmp +=3D snprintf(", ")
> >=20
> > Btwm we have an implementation like that on kernelspace/userspace for
> > the RC API:
> >=20
> > - Kernelspace:
> >   https://github.com/torvalds/linux/blob/master/drivers/media/rc/rc-mai=
n.c#L1125
> >   6 lines of code + a const table with names/values, if we use the same=
 example
> >   for EDAC:
> >=20
> > 	const char *name[] =3D { "foo", "bar" };
> >=20
> > 	for (i =3D 0; i < ARRAY_SIZE(names); i++) {
> > 		if (enabled & names[i].type)
> > 			tmp +=3D sprintf(tmp, "[%s] ", names[i].name);
> > 		else if (allowed & proto_names[i].type)
> > 			tmp +=3D sprintf(tmp, "%s ", names[i].name);
> > 	}
> >=20
> >=20
> > - Userspace:
> >   https://git.linuxtv.org/v4l-utils.git/tree/utils/keytable/keytable.c#=
n197
> >   5 lines of code + a const table, if we use the same example
> >   for ras-daemon:
> >=20
> > 		const char *name[] =3D {=20
> > 			[EDAC_FOO] =3D "[foo]",
> > 			[EDAC_BAR] =3D "[bar]",
> > 		};
> >=20
> > 		for (p =3D strtok(arg, " ,"); p; p =3D strtok(NULL, " ,"))
> > 			for (i =3D 0; i < ARRAY_SIZE(name); i++)
> > 				if (!strcasecmp(p, name[i])
> > 					return i;
> > 		return -1;
> >=20
> > 	(strtok handles both space and commas at the above example)
> >=20
> > IMO, this is a lot better, as the alternative would be to have separate
> > sysfs nodes to describe what values are valid for a given edac devnode.
> >=20
> > See, userspace needs to know what values are valid for a given
> > device and support for it may vary depending on the Kernel and
> > device version. So, we need to have the information about what values
> > are valid stored on some sysfs devnode, to allow backward compatibility=
. =20
>=20
> These aren't selectors from a discrete list so the question is more
> whether a syntax of
> <min> value <max>=20
> is intuitive or not.  I'm not aware of precedence for this one.

=46rom my side, I prefer having 3 separate sysfs nodes, as this is a
very common practice. Doing it on a different way sounds an API violation,
but if someone insists on dropping min/max, this can be argued at
https://lore.kernel.org/linux-api/.

On a very quick search:

	$ ./scripts/get_abi.pl search "\bmin.*max"

I can't see any place using min and max at the same devnode.

	$ ./scripts/get_abi.pl search "\b(min|max)"|grep /sys/ |wc -l
	234

So, it sounds to me that merging those into a single devnode is an
API violation.

>=20
> There was another branch of the thread where Boris mentioned this as an
> option. It isn't bad to deal with and an easy change to the code,
> but I have an open question on what choice we make for representing
> unknown min / max.  For separate files the absence of the file
> indicates we don't have any information.
>=20
>=20
> >  =20
> > >=20
> > > So in conclusion, I think the proposed multiple sysfs attribute style
> > > with them reading back the most recent value written is the least bad
> > > solution to a complex control interface.
> > >    =20
> > > >=20
> > > > echo ...=20
> > > >=20
> > > > then writes in the bank.
> > > >      =20
> > > > > ... so we would propose we do not add max_ and min_ for now and s=
ee how the
> > > > > use cases evolve.       =20
> > > >=20
> > > > Yes, you should apply that same methodology to the rest of the new =
features
> > > > you're adding: only add functionality for the stuff that is actuall=
y being
> > > > used now. You can always extend it later.
> > > >=20
> > > > Changing an already user-visible API is a whole different story and=
 a lot lot
> > > > harder, even impossible.
> > > >=20
> > > > So I'd suggest you prune the EDAC patches from all the hypothetical=
 usage and
> > > > then send only what remains so that I can try to queue them.     =20
> > >=20
> > > Sure. In this case the addition of min/max was perhaps a wrong respon=
se to
> > > your request for a way to those ranges rather than just rejecting a w=
rite
> > > of something out of range as earlier version did.
> > >=20
> > > We can revisit in future if range discovery becomes necessary.  Perso=
nally
> > > I don't think it is given we are only taking these actions in respons=
e error
> > > records that give us precisely what to write and hence are always in =
range.   =20
> >=20
> > For RO devnodes, there's no need for ranges, but those are likely neede=
d for
> > RW, as otherwise userspace may try to write invalid requests and/or have
> > backward-compatibility issues. =20
>=20
> Given these parameters are only meaningfully written with values coming
> ultimately from error records, userspace should never consider writing
> something that is out of range except during testing.
>=20
> I don't mind presenting the range where known (in CXL case it is not
> discoverable for most of them) but I wouldn't expect tooling to ever
> read it as known correct values to write come from the error records.
> Checking those values against provided limits seems an unnecessary step
> given an invalid parameter that slips through will be rejected by the
> hardware anyway.

I'm fine starting without min/max if there's no current usecase, provided
that:

1. when needed, we add min/max as separate devnodes;
2. there won't be any backward issues when min/max gets added.

Regards,
Mauro

