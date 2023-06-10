Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39372A908
	for <lists+linux-edac@lfdr.de>; Sat, 10 Jun 2023 06:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjFJErW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Jun 2023 00:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFJErV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Jun 2023 00:47:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0613D
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 21:47:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35A4gGtn021923;
        Sat, 10 Jun 2023 04:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=EaNbI4UZhJAVsDUGyFyhjLhXaYEGgTZtMedKuPs0Jks=;
 b=R71bxttvNnfh9fs7b9aBiT/HUMzJTY2teFyscLXxhoI2CWU6eXL98DbxgBBWLxy7iy3h
 1XzzljY7/9rqbyln3Y2pS51JaGicjHPSkQDIA7t4FPU9Dctc6ZXV4BVtaz6L9yP8mqEY
 pLuZol+fZOoD8JtthdwBHO+vHLdrGCbg8IdM9pkqytaCr1pV/YpvjfGMHYpO6CdByUDz
 TRr7nWMrjR7UYBnuoLQ06ka0q8Dd5rBSEflT1NlypiI7o36cYhYSjR+ulA7Xy/dpWLXg
 gZonivZMrsAIHNrcJaFRvRSXBEx6CjZhZJmOmHu93/4oQv+bYuzvHOx0yjyiNODPhcf3 nA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r4hd881xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jun 2023 04:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1oeKp7xZI6rqzwvzi1AONz2OYgJKEbUyZMP65p0hg/eCrNEVzgMUyivFrcvunx3KPA/kGjSITP/w3PwjlLDwh1u2pGLzEFIPXsejFPY1Et4Zq2wKBJUO3UNGY0ZK4ETk+WkFToGVKPifKAwILGxyXpqvVpuaMR8+3HSMK5y0SA3+tIycFOiJyan3rwOCFQITu+dqi1xB4abIZTL/AAVXWpGXXMfulrPhmCa2H+3TJ6t3oSoQUz4BZVIfwK0ROSDVKjuPaQ1vkGx0u2QDJkTouyNrc9Sy20i+qWgCJDIxIhzs9W7t2MpFVUma7jkjP3vNU1vH+RZIP562/pXRygwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaNbI4UZhJAVsDUGyFyhjLhXaYEGgTZtMedKuPs0Jks=;
 b=eGjJbggmkCHhPt8524rKd9PLh5PMLDsHUQxe/PfLWw36tktgItK5YW0bpZF75OhL0lK3obrYUe7MeX3wGSgQ8k95Azf6yrcja8DZDkw0ya1l4ctlSrsKMKyxjUxCav2XWA13KG73oaYed5V2omCaX1HgUbY/i4+/0+gpe4OKBuwp8anLZUlS9JG5CgvAsuHUBNUP46P5MWZNK5zQwkkTdwXUwOqA5cc0ghJUfBK1WnDoVOeb9MBbXRHWYufTSTioLF+4yoZ1gjIBnCFGXylTaBFKWpPxf46yOUB1gkHpmU6m9q1CG1kbavhJxgYXijzrc66NeOAq0lZ1PcZCNOf97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM6PR02MB4298.namprd02.prod.outlook.com (2603:10b6:5:2a::11) by
 IA0PR02MB9488.namprd02.prod.outlook.com (2603:10b6:208:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Sat, 10 Jun
 2023 04:47:02 +0000
Received: from DM6PR02MB4298.namprd02.prod.outlook.com
 ([fe80::4555:b2b5:d737:bc31]) by DM6PR02MB4298.namprd02.prod.outlook.com
 ([fe80::4555:b2b5:d737:bc31%4]) with mapi id 15.20.6455.037; Sat, 10 Jun 2023
 04:47:01 +0000
From:   Nitesh Gupta <nitegupt@qti.qualcomm.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Nitesh Gupta (QUIC)" <quic_nitegupt@quicinc.com>
CC:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "Mrinmay Sarkar (QUIC)" <quic_msarkar@quicinc.com>,
        "Shazad Hussain (QUIC)" <quic_shazhuss@quicinc.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "Manivannan Sadhasivam (Consultant)" <msadhasi@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: RE: Extending EDAC Framework for supporting Non-Memory Issues
Thread-Topic: Extending EDAC Framework for supporting Non-Memory Issues
Thread-Index: AQHZmtbTbTQ4/BGqv0OT1Ueg74xc16+DcDGA
Date:   Sat, 10 Jun 2023 04:47:01 +0000
Message-ID: <DM6PR02MB4298A388C4B74B3D1519E19CF256A@DM6PR02MB4298.namprd02.prod.outlook.com>
References: <c3aafa0390654997ac7876dadf216549@quicinc.com>
 <20230609133202.GCZIMp0qhhA6UHDQNJ@fat_crate.local>
In-Reply-To: <20230609133202.GCZIMp0qhhA6UHDQNJ@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB4298:EE_|IA0PR02MB9488:EE_
x-ms-office365-filtering-correlation-id: bd09d127-8835-46ff-5680-08db696dbb1e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6l7kFqwduC2hL2GKbqLk9xiuQWE8qYM++3ANJ2doJDHEJPkBAkxKnMbSL7WF0ukjA1x8WN+BkyHtmZ4fW1BWDK1YFUFqN4LzysivLIWEtiKvkjP+jUHskVvKSGYlgt5yeS1R03sZ3CcILD1qR6CdCC5VMgcCI5cnCcWwwUvSMr/XBpvmeVOm9nQA+hEZhW0AWBk/jGaNaRlGdZeBy+wdE4LhyRGzAVFo1+StC53QGUe4rag+xSJURYzl1mAASvAbfIRa9Gxqhb1m0o2nhqfbC7+IF73KSekXxCXP57LU0mOitmhAB4fM238Hyf2wi+bhp2FIhBo1ipn5GBJrESwNAdh+A/FfzJZXdyYOgC3DsotXZqEAOV7yWRBxaRolSoxt82+x4a6AzMMoC1913tRPFC/92VrsBYu3bi/yIa/pFtf1U9GLpbhO0VXNxIJy1WCtyPBxwLYc6C9CXBVfYamv/zATdtPM7pkRNGnjexHfC9kV2an7DVnZlasIaYKvr1E9/Fow3Fhi43Da6Eg4Qwpx5PydUylnbEKxUHh0Iy8249wU6eThFQ5l+HyMHSvr9brvxyvtXj4RXA+Jk44wkdpjTKuqQNUV9uXSW7CPYkb4zyuQ7TdU+zIRuMNGFbhoqHT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4298.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(478600001)(110136005)(54906003)(8676002)(52536014)(5660300002)(8936002)(4326008)(71200400001)(41300700001)(316002)(7696005)(38100700002)(122000001)(9686003)(26005)(38070700005)(107886003)(6506007)(53546011)(186003)(83380400001)(86362001)(2906002)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXlCbmtPQjJPa2VDb3h4UHRzUk5FYUlqTXBuTGRXVDFKenAwVFhKaHFLaWhk?=
 =?utf-8?B?T1dtOEtPeTNLbE43KzJVR0lXS1dxVTVYQ2dRK1BHdHZBVDd5d09LUVdHKzFv?=
 =?utf-8?B?N0lJcjZxNks5cERJbHFkQTB4OGo4NlB4RWUyMytoR3dVVGdxR3F5OC9JejFT?=
 =?utf-8?B?ZjFJSzlPV0pUYm52cHR3eGZLKzdZdnlWeFZZMms0YitPUXhkT08wYXpXaWh1?=
 =?utf-8?B?TlBCV0VEbmljM0VBUEhyb0VoT0Z3TDZVQkxneGdQc2FLUkZqSGFnVGtVaURS?=
 =?utf-8?B?eFBFbjY5enRRSUZVWjdLV2hpTkhQQmpLaC9ZamRqbzYrRjcreGVRdjZXTk9s?=
 =?utf-8?B?Vjd1RUV4Y05zR1d5cjh4T1JHa25VNGVNbHhxQTYvQ1JpT09YdTV5WXk5emlp?=
 =?utf-8?B?U0N5SThaN2U4Y3Y2Q1VwVGR3VXl6SkNxNFcvU1ZYVTF0ODQ4SWltSE9rNjBD?=
 =?utf-8?B?emMxUlVPVXZ0aUMwcUxlOC9mNjdtK1hBR0RVQmVqYm5oeW5LL0JDTE5WSGxy?=
 =?utf-8?B?Sk5KOWFua1E1WEtrRktoTExsRmxzTXJyN2dIRDN2S29XOUkxMGt2dThsWGRX?=
 =?utf-8?B?KzhuRUJGbXE2bEdObysyOTBlTEwxY29KK25OK2tWOW9EaWZxbEloeGFMZ3h5?=
 =?utf-8?B?MzB0MnNJZlJDSEVCZHZ3aWMzc0FybGlSbm16U21XVlBmSlNxODhDa2swdjJa?=
 =?utf-8?B?Rmh4RStCV0ZQT3pwZzBWQnJLNFJLdnJUdWRlSTRZamJBRXZ2MlREQXpaZzQ0?=
 =?utf-8?B?S2lyWnVXSThXN1NkSVhJaG10QTg4N0VJMlRtN1YzWjJmSUMxeU9uYmNUdSt2?=
 =?utf-8?B?dXBBT1VNbHBxa095M3lMK3M2VmsrZ3N1VGZtV011M2dHc1Ezb1hraytGOStk?=
 =?utf-8?B?UjRjM1FOUU9ESlhwSTBCbllpOEdVRm1temNLVzlIdU8zbmxoUXAwbXljT1dJ?=
 =?utf-8?B?cnRiQ0lISE1TY2ZOanpSdzlMaXJEODFjRzFrQ3NqZzNuVk93dklwUStlQlFp?=
 =?utf-8?B?akdkOFRveTdtSHkydW8yb1RjY2NvWWdFTkY5d2YzLzJ5SWp2TjZtYWl1Y1hJ?=
 =?utf-8?B?clVyU3h4RCtmeTRJMUJVbzlaeU1RaW1GbXY5N2dBQmRWekVCNWJpbmltMzBa?=
 =?utf-8?B?SHlMd2x6djhzam14Z2xtN0g3Qmw2ZWMzcVpXM1N6VTNpRERRVEIxSFp0aDl1?=
 =?utf-8?B?bWUybHlNU2J0QytpOUpVTnEwRmVCeW9pbnVxY2ZQWnFVancwdGxxTEV3WnY5?=
 =?utf-8?B?bWpSNUxBS0g3cXVwV0V1Tk11T0dQYXZDOGZvUzJmR2t6dUJ6eTdMa1M0QzlG?=
 =?utf-8?B?dkRLdGx2ZTFvZ241SHhKTGxpWFY2dmlLWkJhekJUbzBVME9GRDdzS2tUMEpZ?=
 =?utf-8?B?cFgyeXErOXozVTlqbElsM2dFUktvQXNBc0ZIZHNucWs1eFdUQXYyd2tFT0dt?=
 =?utf-8?B?blRBck5kVGc1WFhRS0tDR2VFeVlvcjVlUDhkNVBRdkJiQnBmRWJzNVdwQllp?=
 =?utf-8?B?aXhJUWFlVlFDMEk3K2twa21zYmJxbzl3QlRJbkZnenM0NWxkVkMzZm5qOEpE?=
 =?utf-8?B?bXVLQkdXOWhFMFIreGRJaGZVMmhZWWxQbXZJbXpLYVFubXFJNEF1WVl1ZGoz?=
 =?utf-8?B?NCtpT1VERjZaWHFsYlVrTWl6Y2FnZ3BuZjlQaWhUSkVnT2NQMDVHMnZySDht?=
 =?utf-8?B?Q0pwQXZKamNqTjdpUTZQVUVPN1pCNlRPeGNOUC9BM2Nsc3VlNVpxbVpuT3Rx?=
 =?utf-8?B?bEZ2QkcyRGUreTJQWFQwdVZLaHNpcjY4TkM3TTFnMXdxaEZaT0FocEk0TVJ2?=
 =?utf-8?B?MFRkNEh5MURqYzNKVUZRZU9xZGx5eVdyNGV4bkJvY3VWOUlMLzFRb20wVTlR?=
 =?utf-8?B?MnYxUHpKZE9hOE1RM1ZRNFlMaEYzdzgzOXR2NndlVW12UmpjSzc1dWJxT3lp?=
 =?utf-8?B?b1k5b25EUGVBYkkxdlkrblFITHdKVklwUVBYNFRyY2Q3YjNGdE5Fc1ZpbU5w?=
 =?utf-8?B?dkh1bE5BZSt4Mlk2YmdUUkFqWXFVd1ljeHd3OUdWa2xSZC9qcnJwYjVQWXFy?=
 =?utf-8?B?WnIxam5ZSlJ2WXBRZXM1Si9YdVFNRGt2eDM0WXJ5dDVXcjVtVjFicmp0NHNE?=
 =?utf-8?Q?Jak63zbayfkG7LlS+08E2+lGg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q3RPtCt5duidkEhuAjia/uMUEpnq7M2gEb/24f0AxyeNnoSZ+qeStR6nHCowvx4zOek5uR3cRemIjAst27aSdNghoFQlSbEzkN5oC+WcEKnuNGDT69tC7LnO67jc6OrCgOaJFIbgV+Rh4wbraufAM+PrOg64MtFJG5PJ+tOkpZk/AnmkAKaON1MSutD+t8pbKuhqfa5gMhaXTb8RGIgmGdfVI1sSGTvgFffioBbnXRznov4MeMKOUpgj0IL3wJBMaBXx1etyIJwkSmXDVQj+ad9qe/o57+ilmqZIDWNEJof21dG17VLebZn6Yz9TIJrNzeD8fcpXCroGjujP00fcNU2wEa3ZYaH67mn6S3PdBFbpnGYR8FV0YyTX0XEBRlDTWbM7CJ2EcGFiQTu8jYbITd9tDA34ZcQ7T/eNmdqr0qfUp7hSMgwRVhQ5XeZAYOhuQDju/w9fj+5BT4TrQMwRTyGdaL0f3w3US6YkI7UCT7QNuHNeAM8XyCncDdBIaRsS4nuAgfcaZvfSZN4Uu7fFcQJJzRTQV57UZCDe4K6lZIA+4YBtfBTJ9IJIbiG2B9MdHmFrresXUcS4Jkk4+bN66tjNqUl0H+L1i0vQe6y6Tg2woeFga+K1fG0IFb23igVRrsOFlO2RJzPvrg1rz7Xul2eXJLdgl7GMcCGVo2gyWleNdETdCbMTydE0WVdvEbbjG5Yr7keH7RnNE+wCsj37VrjnzKFpJOJGAO1HXK6hSo1WmjSHAvKav4RRxI/xhnlPTQMV1XiLxsl0Yjk4gFsmIGGxBOG7AmaoEKofbwVYHM2HIVgAZo6F++CWtZ4u65GKfoWrACQUz09MD+sFqbcGKNYooJ8WtQmXVvhs6Q1kH5JXqM0iTIg5HIywR3/zto7kmosT1YoAC3NGsMHgiGxWb8u+5E89cWcwYCjiLJBckz8=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4298.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd09d127-8835-46ff-5680-08db696dbb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 04:47:01.4264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epfNc7k4du5eCOz3F4OpHQlegKl6xDoEUmAyFG0Ketkgt3pvnqyvTq5vwESvJREBuAOQKeUJmEgx87m5BnhLqC3vyeQ1TuoUTSoW7L/4+pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9488
X-Proofpoint-ORIG-GUID: 39VkMgpeto0SJD4XAUvYI8NUE71ZljS_
X-Proofpoint-GUID: 39VkMgpeto0SJD4XAUvYI8NUE71ZljS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-10_02,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=25 mlxlogscore=49
 impostorscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=25 spamscore=25
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306100039
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxp
ZW44LmRlPiANClNlbnQ6IEZyaWRheSwgSnVuZSA5LCAyMDIzIDc6MDIgUE0NClRvOiBOaXRlc2gg
R3VwdGEgKFFVSUMpIDxxdWljX25pdGVndXB0QHF1aWNpbmMuY29tPg0KQ2M6IFRvbnkgTHVjayA8
dG9ueS5sdWNrQGludGVsLmNvbT47IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPjsg
TWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBSb2JlcnQgUmljaHRl
ciA8cnJpY0BrZXJuZWwub3JnPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IFJhbWEgS3Jp
c2huYSAoUVVJQykgPHF1aWNfcmFta3JpQHF1aWNpbmMuY29tPjsgTXJpbm1heSBTYXJrYXIgKFFV
SUMpIDxxdWljX21zYXJrYXJAcXVpY2luYy5jb20+OyBTaGF6YWQgSHVzc2FpbiAoUVVJQykgPHF1
aWNfc2hhemh1c3NAcXVpY2luYy5jb20+DQpTdWJqZWN0OiBSZTogRXh0ZW5kaW5nIEVEQUMgRnJh
bWV3b3JrIGZvciBzdXBwb3J0aW5nIE5vbi1NZW1vcnkgSXNzdWVzDQoNCldBUk5JTkc6IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5
IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0K
DQpIZWxsbywNCg0KT24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMTI6NDM6MTJQTSArMDAwMCwgTml0
ZXNoIEd1cHRhIChRVUlDKSB3cm90ZToNCj4gV2UgaW50ZW5kIHRvIHN0aW11bGF0ZSBzYWZldHkg
ZXJyb3JzIGZvciBQQ0llIHVzaW5nIEVEQUMgZnJhbWV3b3JrLg0KCT5XaGF0IGFyZSAic2FmZXR5
IGVycm9ycyIgYW5kIHdoYXQgZG8geW91IG1lYW4gYnkgInN0aW11bGF0ZSI/DQoNClNhZmV0eSBF
cnJvcnMgYXJlIG1lY2hhbmlzbSBpbmJ1aWx0IGluIFBDSWUgY29udHJvbGxlciB0byBkZXRlY3Qg
YW55IGFub21hbHkgaW4gdGhlIGZ1bmN0aW9uaW5nIG9mIHRoZSBjb250cm9sbGVyLCBiZSBpdCBs
aW5rIHJlbGF0ZWQgb3IgZGF0YSByZWxhdGVkIG9yIGFueXRoaW5nIGFuZCBwYXNzIHRoaXMgaW5m
byB0byBhIHByb2Nlc3NvciB3aGljaCBjYW4gdGFrZSBhY3Rpb25zIHN1Y2ggYXMgcmVzZXR0aW5n
IHRoZSBjb250cm9sbGVyIGlmIGl04oCZcyBhIGZhdGFsIGlzc3VlIG9yIGhhbmRsaW5nIGdyYWNl
ZnVsbHkgaWYgaXTigJlzIGEgbm9uLWZhdGFsIGlzc3VlLg0KDQoNCj4gQXBhcnQgZnJvbSBtZW1v
cnkgZXJyb3JzIHNhZmV0eSBlcnJvcnMgYWxzbyBpbmNsdWRlcyBlcnJvcnMgbGlrZSANCj4gdHJh
bnNhY3Rpb24gdGltZW91dHMsIEFFUidzIGV0Yy4gd3J0IHRvIFBDSWUuDQoJPlNvIGVycm9ycyBy
ZXBvcnRlZCB0aHJvdWdoIEFFUj8NCgk+RGlkIHlvdSBsb29rIGF0IERvY3VtZW50YXRpb24vUENJ
L3BjaWVhZXItaG93dG8ucnN0Pw0KDQpFcnJvcnMgYXJlIHJlcG9ydGVkIHRocm91Z2ggc3BlY2lm
aWMgaW50ZXJydXB0cyBhbmQgdGhlbiBpbnRlcnJ1cHQgaGFuZGxlciBjYW4gdXBkYXRlIHRoZSBz
eXNmcyB0byBpbnRpbWF0ZSB0byB1c2Vyc3BhY2UgZW50aXR5IHRvIGFjdCBhY2NvcmRpbmdseS4N
Cg0KDQo+IE1vZGVsbGluZyB0aGVzZSBlcnJvcnMgb24gbGluZXMgb2YgbWVtb3J5IGVycm9yIGZy
YW1ld29yayB3b3VsZCBub3QgYmUgDQo+IGEgZ29vZCBkZXNpZ24uIENhbiB3ZSBleHRlbmQgdGhl
IGN1cnJlbnQgRURBQyBmcmFtZXdvcmsgdG8gc3RpbXVsYXRlIA0KPiBlcnJvcnMgb3RoZXIgdGhh
biBtZW1vcnkgdG9vPz8NCgk+V2h5IGlzIEVEQUMgYSBnb29kIHBsYWNlIGZvciB0aG9zZT8NCgk+
SGF2ZSBhIGxvb2sgYXQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2VkYWMucnN0IGZpcnN0Lg0K
DQpZZWFoIEkgd2VudCB0aHJvdWdoIGl0IGFuZCB0aGlua2luZyBpZiBFREFDIGJsb2NrIGZ1bmN0
aW9uYWxpdHkgY2FuIGJlIGV4dGVuZGVkIHRvIGRlc2lnbiBzdWNoIGVycm9yIHJlcG9ydGluZyBm
ZWF0dXJlcy4NCg0KUmVnYXJkcywNCk5pdGVzaA0K
