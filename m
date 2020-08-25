Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43531250F0C
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 04:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHYCbN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Aug 2020 22:31:13 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:28480
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbgHYCbM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Aug 2020 22:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haZfSI854kXIX/JkyODsMQzRItAZ4DfEvYArxMWS3qgOmVxdCz8UlQyDWE1SJR2HSqcvZNipvIhtfSU3Wwn+TWTwDRYBGn1NBrrtra5ueSA1sTM14qv/nW7Ff0ZS9bvLPVU7h7SDLTIx4gMtyifg4Tqw7BBGw8BrSCjxk80OuV8usjf4WQ+Xia4Di5cMsJa5XSBA+rj/gwIp2QFpB8SrR7IWceW0UK+Z6Rng07XbS3LdqvNq0k4vaJy5jaH2OHBBhtFY2eLoKo3cdAkYsbJt9TOwD9nX5WB/AYJVhXJHQ6vdRYG5209aEwGBREiwkCKgVckPUXa7+Jfz9ZVirRdzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeWSDGpW1JyF2hN2+LGZudK2Lb1Sc/HD3+r2uSVgR2I=;
 b=hqTKclo937EHiX0WoUX3NqStxQ1yyfq+ETWXmefNjoahwfc8mrES34QOL2pMWOyTtBT4t0osIR+OxGM1ThHLrf6Bo2pM9FZ0xRzmQ26oPvUM3u7kaRsp8FaPweMkKsWgpz3wC0G0qKXlNcD34egWizVeFDZySQ88hewOsywt+24HqQkQ9VqhyWAR426Czx/XrJLdMItywErrrGjQdxP9F8px4bNBPMfW3Pgl8sELYHg215VWJh2qZCU6sGeuXdfJ//e7HmGWL5HpeUcu2iOH3OO3UZmWrviTTExQ3Ppw9pLCFgCtRka2Vh9B9ImpNAhcLm+LkVQDYzt9UlJIWUGoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeWSDGpW1JyF2hN2+LGZudK2Lb1Sc/HD3+r2uSVgR2I=;
 b=S8LCLcYD2PLGxYcIn9gBlWosYOop2PQ2Q8z9eGXnuG0+nBSRtLody+7e4LsqVW/NnrVIkkDbga/VikYgGzd/h/G1DNumcDxYTVXJd9/AW/B79zNBED+4NFnHL2FhEB3lvitJ+x+eg/aVp5rzHSUfk61Se00TFdNClqqgIJTrdL8=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (2603:10a6:803:40::32)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 02:31:09 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c64:3b0c:b102:b2df]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c64:3b0c:b102:b2df%6]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 02:31:09 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     James Morse <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] edac: nxp: Add L1 and L2 error detection for
 A53 and A72 cores
Thread-Topic: [EXT] Re: [PATCH] edac: nxp: Add L1 and L2 error detection for
 A53 and A72 cores
Thread-Index: AQHWVcrvq+aORnEdQEueBFx0LvqOUKlCs7KAgASNEGA=
Date:   Tue, 25 Aug 2020 02:31:09 +0000
Message-ID: <VI1PR04MB4062A3BF31A7002AD45E5200F4570@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20200709082215.12829-1-alison.wang@nxp.com>
 <92811e33-2f57-244b-4b50-c2831b09b835@arm.com>
In-Reply-To: <92811e33-2f57-244b-4b50-c2831b09b835@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3e9cae8-8654-4ab0-83fc-08d8489eed49
x-ms-traffictypediagnostic: VE1PR04MB7407:
x-microsoft-antispam-prvs: <VE1PR04MB7407F21927374B64066790E8F4570@VE1PR04MB7407.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70teVQbIEg3oVADu4iwX1dE8uTTG+VTEx/m3xb4rvLJL9xgxDBLYXXGVGNdzd0DY8QXJeePLjVdbEYpCfu1XK1LSyC38fWJjhsO0SVKwbVLkANYA4EtIzLu35BqVOLU+fuCxZmJYZdYh4Uf7OpaSFQ1jiaNdrJwPJcLM/0agOzCkiglc8k4nUAmE4PynQQD8+zdv5rR0LRB/GHBLO5h1tp0rSw5IMAUW0lRfrYueBXuwzpV10f6b3akCggGG5y7s/KkMvyIgTouRxVEr7R4KcRok5z7H5P5EFJGo38VEU12ILqDASSQ7bfi6MCQ9VK9k9cImleRRjZ0dII6RevrF/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4062.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(44832011)(2906002)(9686003)(66556008)(53546011)(6506007)(83380400001)(64756008)(76116006)(316002)(54906003)(110136005)(71200400001)(66946007)(8676002)(8936002)(66476007)(55016002)(66446008)(478600001)(4326008)(4744005)(52536014)(5660300002)(26005)(186003)(33656002)(7696005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: O6W0lCdmJigRtrpNy0nxB9tKx2XTvwmjBqAcDk+HlkUbXRMZGgwzNsnTTC6PdZ7RliBA+KYlQ0bXvHttI2W9fbS4a2CRh1N1o5aLBJhJOoQggyMB3mqzVHTC+vVBH10n+rA3oy2KPgKkcBvFVBGnk4sLkRsGuSv62baJ/Omjp/9qDs60O4QeTak6fxvJrlBF/rKCGNxEmoTeIFZB6Vdul8SN/WJ/kr3jkZhTcWg5K1qSY+Ei+h7yz9N8I+JgNDOjX1+DIP3GC3I7LMu3WT4SBCfIr4kv6hyOQZKBTvrDUSKk8flZMISpEsG+7rnNi4DR1A/Y1NUnV0ygNlLDq5bRjDzPyLebwbFZ4NaxGOR95Jn1bcBAMXilUWH0V+SNZnE3wITj+ibJjsl8Mb1MJqiDAqH8JEDXiF+Y+VrqOTZNKVUfuVDomzKaAt3uouHn127z0Y9BeOydYLbtZbA1le3/drnJmyOtPTxZ71JdnrNFtJkO5H5Pq6fBPr6QS+xjtprsBRfG0lINfBe/G36ftnTfWMgo14+sAyOYqIUNLOFk2CYLLAfyTiDSsrjQlsiK/EBlBTKSk9NuidAiZV4RiWUiVY6Qfhxv1xxoH83YttI3DCXfH80cMd9AbIBBmddeleB7wWTDDuPGJX+Rljmshb4zqg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4062.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e9cae8-8654-4ab0-83fc-08d8489eed49
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 02:31:09.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QrHV2amE3Dli80EArJPDUkUWCD7cuVdAYx79wljbL3DqnwGDF7gDCFXZ0GfE5TnPI8nf2ElpQ5a9XCiHkgI7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGksIEphbWVzLA0KDQo+IE9uIDA5LzA3LzIwMjAgMDk6MjIsIEFsaXNvbiBXYW5nIHdyb3RlOg0K
PiA+IEFkZCBlcnJvciBkZXRlY3Rpb24gZm9yIEE1MyBhbmQgQTcyIGNvcmVzLiBIYXJkd2FyZSBl
cnJvciBpbmplY3Rpb24gaXMNCj4gPiBzdXBwb3J0ZWQgb24gQTUzLiBTb2Z0d2FyZSBlcnJvciBp
bmplY3Rpb24gaXMgc3VwcG9ydGVkIG9uIGJvdGguDQo+IA0KPHNuaXA+DQo+IA0KPiBBcyB3ZSBj
YW4ndCBzYWZlbHkgd3JpdGUgdG8gdGhlc2UgcmVnaXN0ZXJzIGZyb20gbGludXgsIHNvIEkgdGhp
bmsgdGhpcyBtZWFucyBhbGwNCj4gdGhlIGVycm9yIGluamVjdGlvbiBhbmQgbWF5YmUgU01DIHN0
dWZmIGNhbiBkaXNhcHBlYXIuDQo+IA0KPiANCj4gKEkndmUgbm90IHJlYWQgcGFzdCBoZXJlLi4p
DQo+IA0KW0FsaXNvbl0gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgYWxsIHlvdXIgZGV0YWlsZWQg
Y29tbWVudHMuDQpJIGFncmVlZCB3aXRoIHlvdXIgb3BpbmlvbiB0aGF0IENQVUFDVExSX0VMMSBh
bmQgTDJBQ1RMUiBjYW4ndCBiZSB3cml0dGVuIGluIExpbnV4LiBTbyB0aGUgZXJyb3IgaW5qZWN0
aW9uIGNhbid0IGJlIGRvbmUgaW4gTGludXguIERvIHlvdSBtZWFuIHRoZSBlcnJvciBpbmplY3Rp
b24gY2FuIG9ubHkgYmUgZG9uZSBpbiBmaXJtd2FyZSBiZWZvcmUgTGludXggYm9vdHMgdXA/IElm
IHNvLCB0aGUgc3lzdGVtIGlzIHJ1bm5pbmcgd2l0aCBlcnJvciBpbmplY3Rpb24gZW5hYmxlZCBh
bGwgdGhlIHRpbWUsIGl0IG1heSBiZSBub3QgYSBnb29kIGlkZWEgdG9vLiBBbnkgc3VnZ2VzdGlv
bj8NCg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGlzb24gV2FuZw0KDQoNCg==
