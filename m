Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAF3E5A43
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbhHJMpm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 08:45:42 -0400
Received: from mail-bn1nam07on2083.outbound.protection.outlook.com ([40.107.212.83]:26703
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237627AbhHJMpl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 08:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9GNm9hJDSv5ItluqExw7NOGL42BQUWMoCOdBSVoMX+chP2dUbCrDDr2S/jVFiM75YmWjLqEETju25+Hc4In0SsSjSqkt05cQaZhbO3sCmqFrK8GP/aut3Ckgzb4fHacFjJIZ/IwXt/m2hmVtDqSRlOmNXr0bVx84C3giWXsAe+8xqGl+4SlFRr+ltPHwilIzn9RNgXZQWhN8o+9c049VLpbUIRiMKzIwX8zXy5PXZHndDZvmkpnuGjZkQ6Enq+Bn+VOXEVybSjJWsn7cIbKEik/I0+bj9+MAyKWeR8K87tdKLKH2KRJEHIph/q9fQ+YYIRK8PM0YO1sPT7jQnYFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfIsiL3LJjITn4wQqPAhs2sd6JYabGrOKlrpuOCKJRw=;
 b=jK6eJUfSQZdCNP2cAMWX0Eum8nRZ5sHQr4eZABJOq7e5kp+lbs3D03FPp03BInutlACJR92EUbITE6gcSnRszDguBl11fY0Xk4Tej998cpglM9xc1NrAV/y+zmVyWDL85FpfVoX8xr2sZc92J3m749EDuNCsmnmAOLopoydTemK8SNE1ZhCDNrJuJgMSOPr/PlVtBgu7WAw1REtA6XcksU7imC5mIVStsWypNbJPRnfFcPV2JF2CQZIOSOsi5WXJoWXSCmIqLVzDeAMe/3a1Xbb7Apr4zIVh53jhAO5PsD9zxKr/qyLfiNdZ/TkQcUj6Qux83NGHQPxmeMQ5ChUuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfIsiL3LJjITn4wQqPAhs2sd6JYabGrOKlrpuOCKJRw=;
 b=VkPGTm1djqppyx//e/DQfp6huQcSw/sUnkgXXY43i7FTkpegkHNxw2pCBfoUYXDEXCQPUyIZjipAtbdX+nPosDNah/mPlmQAXdJLUI5vVgGJnJE/LRgPyltqD6XKHiARQlnHc2nNU7W2KIDm2xLRtqzQieWtWLXuYAG9cN0b6Ns=
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Tue, 10 Aug
 2021 12:45:17 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2%9]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 12:45:17 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 1/7] x86/amd_nb: Add Aldebaran device to PCI IDs
Thread-Topic: [PATCH 1/7] x86/amd_nb: Add Aldebaran device to PCI IDs
Thread-Index: AQHXbb9P7GqvZdXQd0S3wZLsK3sYQqtKzQMAgCIgt+A=
Date:   Tue, 10 Aug 2021 12:45:17 +0000
Message-ID: <BL1PR12MB5286FFF1B2B421A2E37DDF44E8F79@BL1PR12MB5286.namprd12.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-2-nchatrad@amd.com>
 <20210719192830.GA19451@aus-x-yghannam.amd.com>
In-Reply-To: <20210719192830.GA19451@aus-x-yghannam.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-10T12:39:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=11e00770-2c05-4be1-86c8-ebc7b50e3c55;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e61ae4-aefb-4f33-d28e-08d95bfcb512
x-ms-traffictypediagnostic: BL1PR12MB5335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB53356BDCBD124246DF1E1C23E8F79@BL1PR12MB5335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XiwHoKyZsca6y8UBHr0sMkkCCK4oZnYgJd+tcAxqf9lK0fVZ+p7Di5obhOhSVrlTh6wKCJCOqg5nvOARh2vAoILK0FIL2CeiWNO1i1/oEHJaxh/zErJychR5Sy6VaVDvLP+Kiik8yClqWbcBNrYVL+NKrWCVHKs8/2ARqtYyb1yierZ3nIcQrdTXDwycCmeeD/KfQBolANNMhYbW+/r6D83bjLXPtgcRnwCm7CgCl6+7VOEACHSKntucgQt1+7cWMmZgX13Fo7HjVXtg9IUpKyrgR+h4d6SvRpxlAcUEO6BfkELi6PWs7eoI6SC7Po3WCRzbUQ7ZdvbnS2rXSJBBxs0osrWkBuk1PToq51RU24mIUDPtmhJ8qcy3y3UZTrmLaSZK8CuOOfq7mYH0oSA55erQhcJY1C4IJMqt+Y34ERQaWnEXo6lGTSK4sZJK/tD6eJBH+DFf9eIFoP5CcjbP//1pMoT8I0lhtX08X2EyvOTMKLV4NcN/rIDwjKL9c7E+eoxguyS0MzGhqQckdnzczZ/5xXnRz7JlriNvKY0WKRNKxwl69v8tdOuI9zfzjapRNIVsANq2Sw1ATt16cn8odI4px7hLKMD2loksdwhIz5iZLGkOCD4JPgb4bohlizbCxFX5PBSE65i660UsELI4O+CThd5Iv4beodW47vDhlE2ywU04d9BB6UDZ/rTApR4L01ek6t9NrxvNYhPPxjj105DGq9VuUEwklvIjN7xl0Lkg+4oU7ETvz7b9ODSllKZZVJzf8Xkz4hbhDNHf/d/0xXsY30MhZ3oRE3eVYo6vIas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(6636002)(316002)(7696005)(52536014)(478600001)(9686003)(71200400001)(54906003)(186003)(76116006)(83380400001)(6862004)(966005)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(53546011)(2906002)(6506007)(55016002)(38100700002)(26005)(4326008)(5660300002)(33656002)(122000001)(8936002)(8676002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ILkZQD+gwvK42HRlJJm7x+aNWnjgXQicHD6nqUJ73aZgIe0tPBbwRAanARXh?=
 =?us-ascii?Q?4tOWL8RjB0FyNgPZZIneA0rgEM6HZdxAERLoa6uWK9A/QDQFgGvpPc1RwT+9?=
 =?us-ascii?Q?bX+q2URScP3hO0IkjfreP49TO0A1r73Y87ejgpfN4eoKc27YM+6e6w9dcw71?=
 =?us-ascii?Q?Gr0QSf4CWIkk3TuXEPeQCDR9jpcOhoQ5o/qxwuidWUJFG8q+PglSFpMsKRIc?=
 =?us-ascii?Q?o67xBY5d4ZJWPIQUNVLIhaV8uS2J0lHIvhRy94Vqugt6wdwYcZzHieDIbY/j?=
 =?us-ascii?Q?WkbMzUnb5wQNSKTmzZEMUi57yRp8Rmb+wLMFnPDDDX2St6R0lpWZUOQUEOtr?=
 =?us-ascii?Q?zTEjFADQDrRraEkfeKqyWMhkgHZyTeGaJ2jdcOVnVVKoam1uUcHi/9g/PdOG?=
 =?us-ascii?Q?E4tXsn5/DDObRf/O99DOtfOk0nPkoBmmrRALKR7Zt7P5/t7j+mp5XmsMAkSL?=
 =?us-ascii?Q?nIUGovghHiTOfdTSQOyixylZ+5V2mF+MW1oV0zM8x/crNr4N7S3vDhLe45un?=
 =?us-ascii?Q?ywjmuQRIOIvqRREtXr3tLpTPAx+J41seuwBn4t5jh+lccoMKhxptuE1kEDXT?=
 =?us-ascii?Q?sHt6oFtbiXqNBwT0Q4dDv9SfVl+5jI+zGco9mKkvDUsndJGheajlfSJUDTYC?=
 =?us-ascii?Q?Vv2meSyhZ9AdAiDTJr/Q+iKUUGfumpfdT7izPhzfQqjc3lZj3dLYdAu8TO1b?=
 =?us-ascii?Q?amvgbPJT8otz+T9ywtkh760CyF3gHm1E1HylL6lN3075ApzyoO5SSBAPwdlI?=
 =?us-ascii?Q?ImXtUSc0X1vraB1eXSbVkwiL5rBPfvflzRSSMnWzTc+61grxrGLwMpOjrd3+?=
 =?us-ascii?Q?LYPo8+Sch4AZ3thFXmQxZChD/YG8euWlR74AYmJgRrPWPm7CnBcgULbcNj1O?=
 =?us-ascii?Q?H2gNeYJTeSLK40BqTDCqsVezo2ZiL8On3qDZlc1gvICEDs6O8VIkKpDvTqGJ?=
 =?us-ascii?Q?bNmgpfw4NU0HecIGYlADq22lT3tPCx5YwbbWeL2trTLZxHz/fbhw9xlhCcIt?=
 =?us-ascii?Q?YUkiV0ft3sEGwe8a/XHaGh0jXd/CI0Y4+BbmMYNCYKwtQUfb1h6fOIHL/fr6?=
 =?us-ascii?Q?IwGpQO88D7fe5Ul4ZjU65T7ZyHclMs3xCSa6jbZ+kbij5Iy1R5b7vAzd1SSq?=
 =?us-ascii?Q?m/Ug6NVik/5JOP0Z7XQXZbWyasUXXNH+rFyxH+Oj5uvX6PAiXqY4BhPwNhem?=
 =?us-ascii?Q?r3iB4NJc9XwfYHWm/Xpa1CwJ5a0LYOS1mK/TvhPAIPVNdXmmkBxMmKSTnxop?=
 =?us-ascii?Q?rtTHs7wCausHTdbe/lb/ozxL6arI3j/JGlGI+o1x1ci6uHMqVxs6IagYmgVm?=
 =?us-ascii?Q?OwBCEVZZgINTz/iypgdCPZCL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e61ae4-aefb-4f33-d28e-08d95bfcb512
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 12:45:17.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygRnVFsHdocPJtcvEH+SIz6KGUBLDSprxUo1dSuxNfOvbzFUa1zsoA9X6nQ75KJZEETpKfbdv6uTsfGyLnVb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Public]

Hi Yazen

-----Original Message-----
From: Ghannam, Yazen <Yazen.Ghannam@amd.com>=20
Sent: Tuesday, July 20, 2021 12:59 AM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; bp@alien8.de; mingo@redhat.com; mchehab@kernel.org
Subject: Re: [PATCH 1/7] x86/amd_nb: Add Aldebaran device to PCI IDs

On Wed, Jun 30, 2021 at 08:58:22PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
>=20
> Add Aldebaran device to the PCI ID database. Since this device has a=20
> configurable PCIe endpoint, it could be used with different drivers.
>=20
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index=20
> 4bac1831de80..d9aae90dfce9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -554,6 +554,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493  #define=20
> PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b  #define=20
> PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
> --

The PCI ID looks right.

But I think this patch can be part of the next patch where this value is fi=
rst used.
[naveenk:] Squashed this change into the 2nd patch and submitted v2 https:/=
/patchwork.kernel.org/project/linux-edac/patch/20210806074350.114614-2-ncha=
trad@amd.com/

Thanks,
Yazen
