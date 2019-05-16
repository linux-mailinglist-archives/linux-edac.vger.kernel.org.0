Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046F620CAF
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 18:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfEPQOR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 12:14:17 -0400
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:28951
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfEPQOR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 12:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLQwbxuVczunKXiyOo53v9WY/uaQkSZArir3h/1vwgY=;
 b=IRjHdStxxsKsDTn7HYtnkppAcf3fcXXbGhOTZ01n7NUyRQnxCerZD6FQFMhgHbo7zvmSn/5twx4O1FY2fP05jEHTd+/yJAFqNK6iRAvxds+bmmkPwoHr1p+qazlU6xqRD1DjNvuTxmxE8EHDvwFmGKmopt1zM8RCpcQ1qoGUluA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2701.namprd12.prod.outlook.com (52.135.103.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 16:14:14 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 16:14:14 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbA=
Date:   Thu, 16 May 2019 16:14:14 +0000
Message-ID: <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
In-Reply-To: <20190516155202.GA11517@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [208.54.70.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5742ab5-cc7f-4260-db01-08d6da1989f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2701;
x-ms-traffictypediagnostic: SN6PR12MB2701:
x-microsoft-antispam-prvs: <SN6PR12MB27016400EEBADBF496575A6AF80A0@SN6PR12MB2701.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(13464003)(26005)(71190400001)(71200400001)(25786009)(478600001)(6246003)(66066001)(72206003)(33656002)(8936002)(52536014)(74316002)(5660300002)(6916009)(53936002)(68736007)(64756008)(66446008)(66556008)(66476007)(76116006)(73956011)(66946007)(256004)(76176011)(6116002)(81166006)(2906002)(6436002)(11346002)(446003)(476003)(53546011)(229853002)(86362001)(7696005)(3846002)(81156014)(7736002)(102836004)(6506007)(8676002)(99286004)(186003)(305945005)(9686003)(55016002)(316002)(486006)(54906003)(14454004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2701;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OG1htUxpCLE/QAYVg26VI89/3l1PTRWDElvzbpv4HuFu3o9WaVzal2cvn7SQ76BI5uxVUzsn7ZiXmufnhos4GxZi5e9U1qS+80Jv2qmMSwEttYsxUKmYkGxS3YvgZ//Dwhm853izsC+batlCLU/nS1TrnjBOWmPpucdFCO3ZLQCgCRwAwpD4JZ/yqv2iXLXgg/ppOscFh1iwTtJlhfQtkr/HIe3fw1FCNh1TBaSAY+nGPURuYohIIbv4Wg/PDpfGiFOML6VXw+D7OEXxri5GTHIv93O4cAbjM/AgXew0Tg62Zs/pubX9pZ9XOciAdCa5c2YhAwEcydYeoKajJBEGZ4PgAIN6/KccIfE3Zb/SeRX4y3PhTZI1RKJIlQ412tlavSTacKCWuEjLeOuv5eT82bBcWKWtIp7qBCF3xjHSj1w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5742ab5-cc7f-4260-db01-08d6da1989f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 16:14:14.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Thursday, May 16, 2019 10:52 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; bp@suse.de;=
 x86@kernel.org
> Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set i=
n hardware
>=20
>=20
> On Tue, Apr 30, 2019 at 08:32:20PM +0000, Ghannam, Yazen wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/c=
ore.c
> > index 986de830f26e..551366c155ef 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -1567,10 +1567,13 @@ static void __mcheck_cpu_init_clear_banks(void)
> >       for (i =3D 0; i < this_cpu_read(mce_num_banks); i++) {
> >               struct mce_bank *b =3D &mce_banks[i];
> >
> > -             if (!b->init)
> > -                     continue;
> > -             wrmsrl(msr_ops.ctl(i), b->ctl);
> > -             wrmsrl(msr_ops.status(i), 0);
> > +             if (b->init) {
> > +                     wrmsrl(msr_ops.ctl(i), b->ctl);
> > +                     wrmsrl(msr_ops.status(i), 0);
> > +             }
> > +
> > +             /* Save bits set in hardware. */
> > +             rdmsrl(msr_ops.ctl(i), b->ctl);
> >       }
> >  }
>=20
> This looks like it will be a problem for Intel CPUs. If
> we take a CPU offline, and then bring it back again, we
> ues "b->ctl" to reinitialize the register in mce_reenable_cpu().
>=20
> But Intel SDM says at the end of section "15.3.2.1 IA32_MCi_CTL_MSRs"
>=20
>         "P6 family processors only allow the writing of all 1s or all
>         0s to the IA32_MCi_CTL MSR."
>=20

I can put a vendor check on the read. Is that sufficient?

Thanks,
Yazen
