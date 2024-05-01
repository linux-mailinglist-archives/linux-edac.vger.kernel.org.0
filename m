Return-Path: <linux-edac+bounces-988-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631748B89EF
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 14:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FC1B21D36
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45389824A3;
	Wed,  1 May 2024 12:24:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400F4F20C;
	Wed,  1 May 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566276; cv=none; b=QdNabGahLpjALqEfMKP6Cf7979f1kFTC2RAxqG2Y4vkQz5uIyJdueSqRcZTSqrTnzL5NBbLpzjONXaBxcAZXXRvyPLmZ1+qhHqQSsiTTB/RS09RnwisvfJ/SditcRhF6+nu+ykT7hAO1qCL1zYk8TF++jlfB8ph0YRXZqtNANL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566276; c=relaxed/simple;
	bh=qVnDhd01gJ3gZCSundBV8CKrCGWQfxZkVcoyP18X+7s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+QxGaFjqMUY7FHAcSKF+CrfI9rX0yP0RZcJJjJq+IZf0pK4Slb1Ftmq8E6a7A5EbhiWHqsH+enX59VYCwMB1VSYVlX0NN42xu9NXl/tWUjTrZ7i/z7/7gCvcCPGV6G6TOjh5AMPMS9aNMaSDW0x4rE8FLspD3wO24iu4HKhdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTx5755tPz687NT;
	Wed,  1 May 2024 20:21:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C746140B73;
	Wed,  1 May 2024 20:24:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 13:24:30 +0100
Date: Wed, 1 May 2024 13:24:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "Luck, Tony"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "Jiang, Dave" <dave.jiang@intel.com>, "Schofield,
 Alison" <alison.schofield@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
	"oohall@gmail.com" <oohall@gmail.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"Preble, Adam C" <adam.c.preble@intel.com>, "leoyang.li@nxp.com"
	<leoyang.li@nxp.com>, "lukas@wunner.de" <lukas@wunner.de>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
	<rrichter@amd.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tsaur, Erwin"
	<erwin.tsaur@intel.com>, "Kuppuswamy, Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Wanyan, Feiting" <feiting.wanyan@intel.com>,
	"Wang, Yudong" <yudong.wang@intel.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "qingshun.wang@linux.intel.com"
	<qingshun.wang@linux.intel.com>
Subject: Re: [PATCH v3 1/3] PCI/AER: Store UNCOR_STATUS bits that might be
 ANFE in aer_err_info
Message-ID: <20240501132429.00002b4a@Huawei.com>
In-Reply-To: <SJ0PR11MB6744C3EAA6E9D738EA0D3BAC92142@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240417061407.1491361-1-zhenzhong.duan@intel.com>
	<20240417061407.1491361-2-zhenzhong.duan@intel.com>
	<20240422171629.00005675@Huawei.com>
	<SJ0PR11MB6744EC971D1BE6F3119EEA9992112@SJ0PR11MB6744.namprd11.prod.outlook.com>
	<20240426171158.000024d4@Huawei.com>
	<SJ0PR11MB6744C3EAA6E9D738EA0D3BAC92142@SJ0PR11MB6744.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 28 Apr 2024 03:31:11 +0000
"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:

> Hi Jonathan,
>=20
> >-----Original Message-----
> >From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> >Subject: Re: [PATCH v3 1/3] PCI/AER: Store UNCOR_STATUS bits that might
> >be ANFE in aer_err_info
> >
> >On Tue, 23 Apr 2024 02:25:05 +0000
> >"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:
> > =20
> >> >-----Original Message-----
> >> >From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> >> >Subject: Re: [PATCH v3 1/3] PCI/AER: Store UNCOR_STATUS bits that =20
> >might =20
> >> >be ANFE in aer_err_info
> >> >
> >> >On Wed, 17 Apr 2024 14:14:05 +0800
> >> >Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
> >> > =20
> >> >> In some cases the detector of a Non-Fatal Error(NFE) is not the most
> >> >> appropriate agent to determine the type of the error. For example,
> >> >> when software performs a configuration read from a non-existent
> >> >> device or Function, completer will send an ERR_NONFATAL Message.
> >> >> On some platforms, ERR_NONFATAL results in a System Error, which
> >> >> breaks normal software probing.
> >> >>
> >> >> Advisory Non-Fatal Error(ANFE) is a special case that can be used
> >> >> in above scenario. It is predominantly determined by the role of the
> >> >> detecting agent (Requester, Completer, or Receiver) and the specific
> >> >> error. In such cases, an agent with AER signals the NFE (if enabled)
> >> >> by sending an ERR_COR Message as an advisory to software, instead of
> >> >> sending ERR_NONFATAL.
> >> >>
> >> >> When processing an ANFE, ideally both correctable error(CE) status =
and
> >> >> uncorrectable error(UE) status should be cleared. However, there is=
 no
> >> >> way to fully identify the UE associated with ANFE. Even worse, a Fa=
tal
> >> >> Error(FE) or Non-Fatal Error(NFE) may set the same UE status bit as
> >> >> ANFE. Treating an ANFE as NFE will reproduce above mentioned issue,
> >> >> i.e., breaking softwore probing; treating NFE as ANFE will make us
> >> >> ignoring some UEs which need active recover operation. To avoid =20
> >clearing =20
> >> >> UEs that are not ANFE by accident, the most conservative route is t=
aken
> >> >> here: If any of the FE/NFE Detected bits is set in Device Status, d=
o not
> >> >> touch UE status, they should be cleared later by the UE handler. =20
> >Otherwise, =20
> >> >> a specific set of UEs that may be raised as ANFE according to the P=
CIe
> >> >> specification will be cleared if their corresponding severity is No=
n-Fatal.
> >> >>
> >> >> To achieve above purpose, store UNCOR_STATUS bits that might be =20
> >ANFE =20
> >> >> in aer_err_info.anfe_status. So that those bits could be printed and
> >> >> processed later.
> >> >>
> >> >> Tested-by: Yudong Wang <yudong.wang@intel.com>
> >> >> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> >> >> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> >> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> >> ---
> >> >>  drivers/pci/pci.h      |  1 +
> >> >>  drivers/pci/pcie/aer.c | 45 =20
> >> >++++++++++++++++++++++++++++++++++++++++++ =20
> >> >>  2 files changed, 46 insertions(+)
> >> >>
> >> >> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >> >> index 17fed1846847..3f9eb807f9fd 100644
> >> >> --- a/drivers/pci/pci.h
> >> >> +++ b/drivers/pci/pci.h
> >> >> @@ -412,6 +412,7 @@ struct aer_err_info {
> >> >>
> >> >>  	unsigned int status;		/* COR/UNCOR Error Status */
> >> >>  	unsigned int mask;		/* COR/UNCOR Error Mask */
> >> >> +	unsigned int anfe_status;	/* UNCOR Error Status for ANFE */
> >> >>  	struct pcie_tlp_log tlp;	/* TLP Header */
> >> >>  };
> >> >>
> >> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> >> index ac6293c24976..27364ab4b148 100644
> >> >> --- a/drivers/pci/pcie/aer.c
> >> >> +++ b/drivers/pci/pcie/aer.c
> >> >> @@ -107,6 +107,12 @@ struct aer_stats {
> >> >>  					PCI_ERR_ROOT_MULTI_COR_RCV | =20
> >> >	\ =20
> >> >>  					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
> >> >>
> >> >> +#define AER_ERR_ANFE_UNC_MASK =20
> >> >	(PCI_ERR_UNC_POISON_TLP |	\ =20
> >> >> +					PCI_ERR_UNC_COMP_TIME | =20
> >> >	\ =20
> >> >> +					PCI_ERR_UNC_COMP_ABORT | =20
> >> >	\ =20
> >> >> +					PCI_ERR_UNC_UNX_COMP | =20
> >> >	\ =20
> >> >> +					PCI_ERR_UNC_UNSUP)
> >> >> +
> >> >>  static int pcie_aer_disable;
> >> >>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
> >> >>
> >> >> @@ -1196,6 +1202,41 @@ void aer_recover_queue(int domain, =20
> >unsigned =20
> >> >int bus, unsigned int devfn, =20
> >> >>  EXPORT_SYMBOL_GPL(aer_recover_queue);
> >> >>  #endif
> >> >>
> >> >> +static void anfe_get_uc_status(struct pci_dev *dev, struct =20
> >aer_err_info =20
> >> >*info) =20
> >> >> +{
> >> >> +	u32 uncor_mask, uncor_status;
> >> >> +	u16 device_status;
> >> >> +	int aer =3D dev->aer_cap;
> >> >> +
> >> >> +	if (pcie_capability_read_word(dev, PCI_EXP_DEVSTA, =20
> >> >&device_status)) =20
> >> >> +		return;
> >> >> +	/*
> >> >> +	 * Take the most conservative route here. If there are
> >> >> +	 * Non-Fatal/Fatal errors detected, do not assume any
> >> >> +	 * bit in uncor_status is set by ANFE.
> >> >> +	 */
> >> >> +	if (device_status & (PCI_EXP_DEVSTA_NFED | PCI_EXP_DEVSTA_FED))
> >> >> +		return;
> >> >> + =20
> >> >
> >> >Is there not a race here?  If we happen to get either an NFED or FED
> >> >between the read of device_status above and here we might pick up a =
=20
> >status =20
> >> >that corresponds to that (and hence clear something we should not). =
=20
> >>
> >> In this scenario, info->anfe_status is 0. =20
> >
> >OK. In that case what is the point of the check above?
> >If the code is safe to races, it's safe to go ahead without that check
> >on what might race. =20
>=20
> Good question.
> After further digging into the spec, I just found I misunderstood it.
> An UNCUR error raised as ANFE can be raised as NFE in different cases,
> so info->anfe_status can be nonzero here and the race you mentioned
> does exist, the check on PCI_EXP_DEVSTA_FED is also unnecessary.
> Sorry for the misleading. I plan to have below change to fix the race:
>=20
>        unsigned int anfe_status;
>        anfe_status =3D uncor_status & ~uncor_mask & ~info->severity &
>                            AER_ERR_ANFE_UNC_MASK;
>=20
>        if (pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &device_status))
>                return;
>        /*
>         * Take the most conservative route here. If there are
>         * Non-Fatal errors detected, do not assume any
>         * bit in uncor_status is set by ANFE.
>         */
>        if (device_status & PCI_EXP_DEVSTA_NFED)
>                return;
>         info->anfe_status =3D anfe_status;
>=20
> With this change, there is still a small window between reading uncor_sta=
tus
> and device_status to leak ANFE, but that's the best we can do and better
> than clearing NFE. Let me know if you have better idea=F0=9F=98=8A

Worth leaving some breadcrumbs about there being a race (so a comment)
and explain what the side effects of hitting that race are (lost info
on the error I think, but not a missed error)?
>=20
> Thanks
> Zhenzhong
>=20
> > =20
> >> =20
> >> >
> >> >Or am I missing that race being close somewhere? =20
> >>
> >> The bits leading to NFED or FED is masked out when assigning info-
> >>anfe_status.
> >> Bits for FED is masked out by ~info->severity,
> >> bit for NFED is masked out by AER_ERR_ANFE_UNC_MASK.
> >>
> >> So we never clear status bits for NFED or FED in ANFE handler.
> >>
> >> See below assignment of info->anfe_status.
> >>
> >> Thanks
> >> Zhenzhong
> >> =20
> >> > =20
> >> >> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, =20
> >> >&uncor_status); =20
> >> >> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, =20
> >> >&uncor_mask); =20
> >> >> +	/*
> >> >> +	 * According to PCIe Base Specification Revision 6.1,
> >> >> +	 * Section 6.2.3.2.4, if an UNCOR error is raised as
> >> >> +	 * Advisory Non-Fatal error, it will match the following
> >> >> +	 * conditions:
> >> >> +	 *	a. The severity of the error is Non-Fatal.
> >> >> +	 *	b. The error is one of the following:
> >> >> +	 *		1. Poisoned TLP           (Section 6.2.3.2.4.3)
> >> >> +	 *		2. Completion Timeout     (Section 6.2.3.2.4.4)
> >> >> +	 *		3. Completer Abort        (Section 6.2.3.2.4.1)
> >> >> +	 *		4. Unexpected Completion  (Section 6.2.3.2.4.5)
> >> >> +	 *		5. Unsupported Request    (Section 6.2.3.2.4.1)
> >> >> +	 */
> >> >> +	info->anfe_status =3D uncor_status & ~uncor_mask & ~info->severit=
y =20
> >> >& =20
> >> >> +			    AER_ERR_ANFE_UNC_MASK;
> >> >> +}
> >> >> +
> >> >>  /**
> >> >>   * aer_get_device_error_info - read error status from dev and stor=
e it =20
> >to =20
> >> >info =20
> >> >>   * @dev: pointer to the device expected to have a error record
> >> >> @@ -1213,6 +1254,7 @@ int aer_get_device_error_info(struct pci_dev =
=20
> >> >*dev, struct aer_err_info *info) =20
> >> >>
> >> >>  	/* Must reset in this function */
> >> >>  	info->status =3D 0;
> >> >> +	info->anfe_status =3D 0;
> >> >>  	info->tlp_header_valid =3D 0;
> >> >>
> >> >>  	/* The device might not support AER */
> >> >> @@ -1226,6 +1268,9 @@ int aer_get_device_error_info(struct pci_dev =
=20
> >> >*dev, struct aer_err_info *info) =20
> >> >>  			&info->mask);
> >> >>  		if (!(info->status & ~info->mask))
> >> >>  			return 0;
> >> >> +
> >> >> +		if (info->status & PCI_ERR_COR_ADV_NFAT)
> >> >> +			anfe_get_uc_status(dev, info);
> >> >>  	} else if (type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> >> >>  		   type =3D=3D PCI_EXP_TYPE_RC_EC ||
> >> >>  		   type =3D=3D PCI_EXP_TYPE_DOWNSTREAM || =20
> >>
> >> =20
>=20


