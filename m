Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B059EADB
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiHWSWx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiHWSWe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 14:22:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E724D83D;
        Tue, 23 Aug 2022 09:39:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NGDeSp019257;
        Tue, 23 Aug 2022 16:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=f5oYnoqJ4R7cnz6HvAk1OtPokl4+HAosiNy+8Di/wIk=;
 b=zo77NimfRazS4X3RGKJmK3RWwGI85gWafeFARLUENm6WuTkuwYMDfkRmLbkA92lqxyTL
 iTNuU3G+FXvwcKboqasxDA7AjRN8St1ALqrjimkHBBPgHgSN+dfZFfXA8W8OzvOhtD/5
 a+6JYsjqgq+Ei5qPd1sf+UNoDaXvqpLPiazdLnrNeXk34/9/qojlmOqDKFs79IvPwgLF
 pKwiAWsI7eyh0zV0JujptdT9pLAzMLO05kqXhmcV0RhZd9chHShAewKHWFQQAi7hyUOF
 //tfEO4mqIlMvZQH/WSFsBxmbA4Fhp0c2lNQWFBZP1GjbuYhHdCd67fqsquvvh4YSucS ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23s274-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 16:38:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27NFv4lg018278;
        Tue, 23 Aug 2022 16:38:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjehpgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 16:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg6Ds9iAMptdyd6ig/zM/vBNS1uD4erUkIAiSR0shEIF/97dCQV/o2/brDQrQ6uTBOqfYWc+qXe5vqxQeuVCYWc6dHO10zGPne/E4Q7xq76LaGKXd1JD5nWhfgGZd6iiLjnc4F5edW7kyxxosvQKgFypopkpQ2igKqv7eavhPE/244gPqlRgQALVcESFwsD55P4Ev3WngIJaqKgOQh+pPnr1LzAd9dYr7BUJrhplEo9VZi6OF88UGDDm8zmmNoX1LM6dPnlcONsVYFT4rvQTIW3/m3e9FF+8lyPGrAqH6Of+OLt48JC7ilt9BFJhoO33O2Of67IHhjO7CXRUu1QGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5oYnoqJ4R7cnz6HvAk1OtPokl4+HAosiNy+8Di/wIk=;
 b=btDUegKzJSFzxcumtlbK+JapMgVMX10C74ezxNH5XMlUtA3K5eurM7/+Hp8NPWxWPPAXtwUdHBxo5BL4reh5pOQqxcwd8jjaQXczNqyeDPiHQMSohZanvDpHIphBOSlaXEuvLhbwA18oL/sxwoIYK7ahNFoYA/0KBGrJyfCgA4B1HLwQDUBD+d37qdWTGBwBoC1e5s7lSJMLOvM23MqTa2i6FNRpYnF364LeN1G60V86ryliS4Uw7F1Tuq6sprWadFd/sou2Ft+oB0Xmf34cuNn2xuQFmLQ5pA3BcBm+TLD0+s9dKVDFcyTy3sVOeLIZTdiDc1z6c6h+9ymj/gGy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5oYnoqJ4R7cnz6HvAk1OtPokl4+HAosiNy+8Di/wIk=;
 b=MZNqaCiF+Lxg7wX/c0+g+gvur3hEvhIWhS2/D8nL8SnCmQErkXgLS6Znuo5tXIQwcdOoNINtt4SvEfOc4k7uJI293Drfa+GxVnciMvDZl0x4W/uqSKooj+78NPJSa3GXEn19XuQtojlz4Y6lWELvz9ub1btFJ+YYsMqudB6HKNA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 16:38:33 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::14cf:1363:8f81:9c81%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 16:38:33 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v7] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYpqk2x6w5xzWZA026ohxrqJ0Fu62c35cAgAimK4CAACqTAIAXH+gA
Date:   Tue, 23 Aug 2022 16:38:33 +0000
Message-ID: <d6c8eee3-53fb-d234-faa3-40dd055441a6@oracle.com>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <Yuo3dioqb9mDAOcT@gmail.com>
 <833288b3-4838-63b8-b22b-f22538877957@oracle.com>
 <62f19c8e795d1_1b3c29448@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62f19c8e795d1_1b3c29448@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b47de0c-6f9a-42d2-11aa-08da8525eb3c
x-ms-traffictypediagnostic: BY5PR10MB4388:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rW9z05JbR6g+vurCrkJt72Dfyn2KRnlMGhIa5lZTy5cgAEBVCEx0ZnBvpKd2ZOLqjzp7phpzb6EhAfCfqibPO80AoBMl5Y2SDg4/n9AYqfQT6zTwnm80SxOdLfVG5yxuS/sQp0DvXyZ+fqG+8JOlNpHleJ+LdjnUeJslgp3f0a9WLeIVlVfFNryyEOSr4Ns7vwZFae1LVtOZuw4bGnLi7LLNyyA0qdyUc13GGkWeENBd+DBFvpqxlSpsft2jYe5/qK1muatgPR/NYRMOReQXxi/Dh8qChAaSJOLH5mt5P1h6g8OFeMlwKsaHrwbHlk+6dh5APxjOdFx25K9x338isc8HkVjSzRRSjE6Ai3hqzoeSJAba/Czz7uYhJKBsROdkbHjJORoOKbYHYPhHRBNx1P0rBDyXnX88cqfG/TxbdBhN9izxGKipCTsg4Hi3q4R5+S3ikfVCxP328r3/kJ8ZxfNkzgSQrczrJVjxr3JQXWwCw7G8PR0BaQ6P2t2wOnMYNX1eImjkDI9cR4o5e1O8gUD6xKCNaIipBgBxfFaK8wOyA3eQsAcpmrlMoZD1imQ4JAQlEl7sDM2eWKgxHcrgPjkFdZc1cJ+BGlDDn3TUIspLQz4hdqxdOhaaNQ5oAfI5A1S10sxAMcdYH0GonfiCxV0rs2HA7hMW1/goIctqGnoGZlOj8Wg90YVaAqNGCcn8NAvZRpVY4r2srR3F74ZSB11hmEtqRvmVd4fVFzsaDm5b6ft0c43lyH/Q0sq6W10GHiQO24Iyduc7tWUevc+RGDNh2GrS8Zpcv+LiA9nYtKx4lDvm9h7VTdSN79lbVbaLsJ2GQysT3qKJgv9/pfccV1Y8HQjKn5tRKCRIpsx9dww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(366004)(396003)(136003)(8936002)(122000001)(7416002)(2906002)(966005)(2616005)(478600001)(6486002)(71200400001)(83380400001)(5660300002)(44832011)(31686004)(36756003)(86362001)(66476007)(186003)(66556008)(66946007)(38100700002)(91956017)(66446008)(64756008)(76116006)(54906003)(110136005)(31696002)(316002)(4326008)(8676002)(38070700005)(6512007)(26005)(41300700001)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUFSMlYvcDlkU29veEhMNmFjTTJsK21nbVM3YXhHYXZzSFM2cTB6SmdYZ3pL?=
 =?utf-8?B?YlFNb1JCcG53OWU4alIxMG93V2MyaUxTZWtXRFNKWE0vbTZ5YU5URzBERmNQ?=
 =?utf-8?B?ZE5ETE9RV09JbjlsazIvbXZBSHF6cjJCTVdpY3ZTRnJvODRaZHh1eWpDWHJ0?=
 =?utf-8?B?MVgybldHV0wzRVBVQnUrY0FXUTBDUFRLckExcHZnbVFZYkM1TlFlYjlXenFl?=
 =?utf-8?B?Z1pzU21RTTZtZmNHWXdYMTJiRkVXSDM2RUpaeXBvUjZhRFk2M1B3WE1xZHgw?=
 =?utf-8?B?SjBYRU10cTZrTkVQVkc2Q0JramdnTy9XdUdPWmdUVlVFMHA4U0NDNFVrc3pt?=
 =?utf-8?B?QnkrZXMxTzRuN3hWZ0Z0RG55VHBOTlVqWTRLRGR0MnFCYUtXWHcwYUs0QTY0?=
 =?utf-8?B?Wjl4MWVPdjBFeXRlSGdtNHFJK2F3WGZNRW5wWStRTExnTGpkbEMvZWJWOWFQ?=
 =?utf-8?B?UURCMjNvTHlOU2VqZm9PTkdYTTFueUhFemVuQ3R5ajhVZDVYUzgzTE8rbjNJ?=
 =?utf-8?B?OTBwMXpnUWZybkNhQ0o3S2xqR1BVYkRZT1k0TDFjOFJ2c01NUTdpUldUTHdL?=
 =?utf-8?B?R2JpOHlHVzkzRGVyNGxxZVJ2SEtJZm5WYWRndG4rbTdPQmhSV1c2S3BFZWI5?=
 =?utf-8?B?clpoNWczNkE4Q3NBUmFzdDJ0YW5YZkNvdDBJR0d5QzRUOUNKY3pFRGpnbW5v?=
 =?utf-8?B?bVEyNFdmNXc0QUZxL0pJOE1Mc1RsY3VBZWMzL0RraURGVWhDMFI1czJtck4v?=
 =?utf-8?B?SVNwZHpwTlBWa1ZBWDhyeHRpN24xdXQrWXpRTGRtQytMbjBqVDBBREREVVRJ?=
 =?utf-8?B?elZwMVJJRW1oQ1ZLWXh6R3QvQWpmK0ZwQmNDRDEzYTR1VE5JVmRaU3VaeldQ?=
 =?utf-8?B?S1JZOUpobjV2MVg5Z2EwQ0QweGNEcEZNcnpBOFlleDUwcldacWttSndJbytj?=
 =?utf-8?B?T1E5TWVFc3p2ckl2Z3NJVWJucHBUZjhQL3k5eUplTkx0SThwUzYzcDZlRFRV?=
 =?utf-8?B?NUg1YUxIaC94QjdzajRUemNnZHVyc2YwQ2ZqUzBEV3M0R3hGRGMvVlpvMmVl?=
 =?utf-8?B?SGZ1SGp6Q1dXZkpsNDZ2VEhRTythRHc2aTM3OXJxRXRscTJUcTlaSFBWaEdp?=
 =?utf-8?B?QVUvbHlSQTErUGxVKzJ3QnpaMjI4Ty8xMTU4MThMN2hjUFMzSmpDRzVENDRt?=
 =?utf-8?B?dDViRWxzM2tLMUYzS2l2dE01b2d4YkV5bVlTY25DMUNaTjVMMW95eG9tQnZE?=
 =?utf-8?B?bGZlMGtiNUVIRER4QlNlT090bXlUWVZhQm1vNmtrOVhhOU5SSEtwWStJTmNn?=
 =?utf-8?B?c3hEZzhhU3RaL2liNE9iYzkwY1lZRTgxMnF3bGE4aGFlYlpQc1lOQTRUcG5R?=
 =?utf-8?B?STRpUktoZk9HYjNuSHA5Y2gxZkl2VGM1NnkydWkwZ1NYQlV6RlQwM1g4Vy9V?=
 =?utf-8?B?UUppQXE3RzF3V2UyNkd4WUVyaURBVVhPUExJcmp1SWZaeExmVnZWcEVVdW45?=
 =?utf-8?B?NkUvUXp5UW45b3dqbjJZL2pZdCtFTHdrakFES2NMUGZWblIyc29JZFAycXcz?=
 =?utf-8?B?L3RNRU9GMmNmajJDTmd6SUlOY2Z5bFhIK25VVTJPVVdQR3NoY2ZUQUZoWno2?=
 =?utf-8?B?Zm5LeUlaeEZMbks1WUJnU280N1RpVXNEWEttcThKdXFaRUw3ckhyaEJBWnpM?=
 =?utf-8?B?NkZVZHExQTVuT3hIZnh5UEg5c0VmbVU2VkpRRHVobnMrSzQ3SU0yVUhJYVcx?=
 =?utf-8?B?cFFSWXVCeHV4eGxPSUVWMTJCZERob0JHYTlvb3JqY1MyK3VERnNJM1paWU9s?=
 =?utf-8?B?WHNTZVlXZkljU1Y0OCttbHZ6eGw2cWgrbFFMaGZWV3F2YWJraEJzYWorUEdm?=
 =?utf-8?B?aVFQWkJTVHYxSUViTXBmaG5BK1prUW43RTRHdmVZenZudWFaT29Ec1dFV29H?=
 =?utf-8?B?L1NHY21UaUJBZE93RGFTSFk2dEY0azlEVlhQeTRickxUU2dqMXJqSDM2N3Bx?=
 =?utf-8?B?cFRKVFprMngyangzMVdBTzQ2WHBQY1pLZERLZDBEVGREb0Y4SDRWR2JOUytz?=
 =?utf-8?B?MVBqMFNOQXpzL2k4M050TjZLZFpaeFZqa29LZFlYSTZYcVczTTB0Si9GSXJC?=
 =?utf-8?Q?PVh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <273D498600A62749A22B772F23C17CCF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b47de0c-6f9a-42d2-11aa-08da8525eb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 16:38:33.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVzi1kma+GW1QfD6H07iFF2hZWrTfGiCt6DTuJHNcKduXxl+QGUIEZ/XpoB/67x5ndXKmmX5wPHtslnzwKuM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230066
X-Proofpoint-ORIG-GUID: 18h4lxw1JYde7X4mZw6iPtkQdx2s8wkD
X-Proofpoint-GUID: 18h4lxw1JYde7X4mZw6iPtkQdx2s8wkD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

ID4+PiBJIHN1cHBvc2UgdGhpcyB3YW50cyB0byBnbyB1cHN0cmVhbSB2aWEgdGhlIHRyZWUgdGhl
IGJ1ZyBjYW1lIGZyb20gDQooTlZESU1NDQogPj4+IHRyZWU/IEFDUEkgdHJlZT8pLCBvciBzaG91
bGQgd2UgcGljayBpdCB1cCBpbnRvIHRoZSB4ODYgdHJlZT8NCiA+Pg0KID4+IE5vIGlkZWEuICBN
YWludGFpbmVycz8NCiA+DQogPiBUaGVyZSdzIG5vIHJlYWwgTlZESU1NIGRlcGVuZGVuY3kgaGVy
ZSwganVzdCBhIGdlbmVyYWwgY2xlYW51cCBvZiBob3cNCiA+IEFQRUkgZXJyb3IgZ3JhbnVsYXJp
dGllcyBhcmUgbWFuYWdlZC4gU28gSSB0aGluayBpdCBpcyBhcHByb3ByaWF0ZSBmb3INCiA+IHRo
aXMgdG8gZ28gdGhyb3VnaCB0aGUgeDg2IHRyZWUgdmlhIHRoZSB0eXBpY2FsIHBhdGggZm9yIG1j
ZSByZWxhdGVkDQogPiB0b3BpY3MuDQoNCisgSHVhbmcsIFlpbmcuDQoNCng4NiBtYWludGFpbmVy
cywNCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFub3RoZXIgcmV2aXNpb24uDQoN
CnRoYW5rcywNCi1qYW5lDQoNCg0KT24gOC84LzIwMjIgNDozMCBQTSwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBKYW5lIENodSB3cm90ZToNCj4+IE9uIDgvMy8yMDIyIDE6NTMgQU0sIEluZ28gTW9s
bmFyIHdyb3RlOg0KPj4+DQo+Pj4gKiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+Pj4NCj4+Pj4gV2l0aCBDb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9uZml0OiByZWx5
IG9uIG1jZS0+bWlzYyB0byBkZXRlcm1pbmUNCj4+Pg0KPj4+IHMvQ29tbWl0L2NvbW1pdA0KPj4N
Cj4+IE1haW50YWluZXJzLA0KPj4gV291bGQgeW91IHByZWZlciBhIHY4LCBvciB0YWtlIGNhcmUg
dGhlIGNvbW1lbnQgdXBvbiBhY2NlcHRpbmcgdGhlIHBhdGNoPw0KPj4NCj4+Pg0KPj4+PiBwb2lz
b24gZ3JhbnVsYXJpdHkiKSB0aGF0IGNoYW5nZWQgbmZpdF9oYW5kbGVfbWNlKCkgY2FsbGJhY2sg
dG8gcmVwb3J0DQo+Pj4+IGJhZHJhbmdlIGFjY29yZGluZyB0byAxVUxMIDw8IE1DSV9NSVNDX0FE
RFJfTFNCKG1jZS0+bWlzYyksIGl0J3MgYmVlbg0KPj4+PiBkaXNjb3ZlcmVkIHRoYXQgdGhlIG1j
ZS0+bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVzLCBoZW5jZSBpbmplY3RpbmcNCj4+Pj4g
MiBiYWNrLXRvLWJhY2sgcG9pc29ucyBhbmQgdGhlIGRyaXZlciBlbmRzIHVwIGxvZ2dpbmcgOCBi
YWRibG9ja3MsDQo+Pj4+IGJlY2F1c2UgMHgxMDAwIGJ5dGVzIGlzIDggNTEyLWJ5dGUuDQo+Pj4+
DQo+Pj4+IERhbiBXaWxsaWFtcyBub3RpY2VkIHRoYXQgYXBlaV9tY2VfcmVwb3J0X21lbV9lcnJv
cigpIGhhcmRjb2RlDQo+Pj4+IHRoZSBMU0IgZmllbGQgdG8gUEFHRV9TSElGVCBpbnN0ZWFkIG9m
IGNvbnN1bHRpbmcgdGhlIGlucHV0DQo+Pj4+IHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyIHJlY29y
ZC4gIFNvIGNoYW5nZSB0byByZWx5IG9uIGhhcmR3YXJlIHdoZW5ldmVyDQo+Pj4+IHN1cHBvcnQg
aXMgYXZhaWxhYmxlLg0KPj4+Pg0KPj4+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzdlZDUwZmQ4LTUyMWUtY2FkZS03N2IxLTczOGI4YmZiODUwMkBvcmFjbGUuY29tDQo+Pj4+DQo+
Pj4+IFJldmlld2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4N
Cj4+Pj4gUmV2aWV3ZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4NCj4+Pj4gLS0tDQo+
Pj4+ICAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYyB8IDEzICsrKysrKysrKysrKy0N
Cj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+PiBpbmRleCA3MTcxOTI5MTVmMjgu
LjhlZDM0MTcxNDY4NiAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
YXBlaS5jDQo+Pj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4+PiBA
QCAtMjksMTUgKzI5LDI2IEBADQo+Pj4+ICAgIHZvaWQgYXBlaV9tY2VfcmVwb3J0X21lbV9lcnJv
cihpbnQgc2V2ZXJpdHksIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0KPj4+PiAg
ICB7DQo+Pj4+ICAgIAlzdHJ1Y3QgbWNlIG07DQo+Pj4+ICsJaW50IGxzYjsNCj4+Pj4gICAgDQo+
Pj4+ICAgIAlpZiAoIShtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9Q
QSkpDQo+Pj4+ICAgIAkJcmV0dXJuOw0KPj4+PiAgICANCj4+Pj4gKwkvKg0KPj4+PiArCSAqIEV2
ZW4gaWYgdGhlIC0+dmFsaWRhdGlvbl9iaXRzIGFyZSBzZXQgZm9yIGFkZHJlc3MgbWFzaywNCj4+
Pj4gKwkgKiB0byBiZSBleHRyYSBzYWZlLCBjaGVjayBhbmQgcmVqZWN0IGFuIGVycm9yIHJhZGl1
cyAnMCcsDQo+Pj4+ICsJICogYW5kIGZhbGwgYmFjayB0byB0aGUgZGVmYXVsdCBwYWdlIHNpemUu
DQo+Pj4+ICsJICovDQo+Pj4+ICsJaWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJf
TUVNX1ZBTElEX1BBX01BU0spDQo+Pj4+ICsJCWxzYiA9IGZpbmRfZmlyc3RfYml0KCh2b2lkICop
Jm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaywgUEFHRV9TSElGVCk7DQo+Pj4+ICsJZWxzZQ0K
Pj4+PiArCQlsc2IgPSBQQUdFX1NISUZUOw0KPj4+PiArDQo+Pj4+ICAgIAltY2Vfc2V0dXAoJm0p
Ow0KPj4+PiAgICAJbS5iYW5rID0gLTE7DQo+Pj4+ICAgIAkvKiBGYWtlIGEgbWVtb3J5IHJlYWQg
ZXJyb3Igd2l0aCB1bmtub3duIGNoYW5uZWwgKi8NCj4+Pj4gICAgCW0uc3RhdHVzID0gTUNJX1NU
QVRVU19WQUwgfCBNQ0lfU1RBVFVTX0VOIHwgTUNJX1NUQVRVU19BRERSViB8IE1DSV9TVEFUVVNf
TUlTQ1YgfCAweDlmOw0KPj4+PiAtCW0ubWlzYyA9IChNQ0lfTUlTQ19BRERSX1BIWVMgPDwgNikg
fCBQQUdFX1NISUZUOw0KPj4+PiArCW0ubWlzYyA9IChNQ0lfTUlTQ19BRERSX1BIWVMgPDwgNikg
fCBsc2I7DQo+Pj4NCj4+PiBMR1RNLg0KPj4+DQo+Pj4gSSBzdXBwb3NlIHRoaXMgd2FudHMgdG8g
Z28gdXBzdHJlYW0gdmlhIHRoZSB0cmVlIHRoZSBidWcgY2FtZSBmcm9tIChOVkRJTU0NCj4+PiB0
cmVlPyBBQ1BJIHRyZWU/KSwgb3Igc2hvdWxkIHdlIHBpY2sgaXQgdXAgaW50byB0aGUgeDg2IHRy
ZWU/DQo+Pg0KPj4gTm8gaWRlYS4gIE1haW50YWluZXJzPw0KPiANCj4gVGhlcmUncyBubyByZWFs
IE5WRElNTSBkZXBlbmRlbmN5IGhlcmUsIGp1c3QgYSBnZW5lcmFsIGNsZWFudXAgb2YgaG93DQo+
IEFQRUkgZXJyb3IgZ3JhbnVsYXJpdGllcyBhcmUgbWFuYWdlZC4gU28gSSB0aGluayBpdCBpcyBh
cHByb3ByaWF0ZSBmb3INCj4gdGhpcyB0byBnbyB0aHJvdWdoIHRoZSB4ODYgdHJlZSB2aWEgdGhl
IHR5cGljYWwgcGF0aCBmb3IgbWNlIHJlbGF0ZWQNCj4gdG9waWNzLg0KDQo=
